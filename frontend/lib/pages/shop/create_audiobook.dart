import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show File, Platform;
import 'package:frontend/api/shop_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/proto/shop/v1/shop.pbgrpc.dart' as shoppb;

class CreateAudioBookPage extends StatefulWidget {
  const CreateAudioBookPage(
      {super.key,
      required this.shopApi,
      required this.host,
      this.initialTitle,
      this.initialAuthor,
      this.initialPriceCents,
      this.resumeAudiobookId,
      this.resumeUploadUrl,
      this.resumeStatus,
      this.forceStatus});

  final String host;
  final ShopApi shopApi;
  final String? initialTitle;
  final String? initialAuthor;
  final int? initialPriceCents;

  final String? resumeAudiobookId;
  final String? resumeUploadUrl;
  final shoppb.MediaStatus? resumeStatus;
  final bool? forceStatus;

  bool get isResume => resumeAudiobookId != null && resumeUploadUrl != null;

  @override
  State<CreateAudioBookPage> createState() => _CreateAudioBookPageState();
}

class _CreateAudioBookPageState extends State<CreateAudioBookPage> {
  final title = TextEditingController(text: 'Demo Audio');
  final author = TextEditingController(text: 'Admin');
  final price = TextEditingController(text: '12900');
  String? pickedPath;
  String status = '';
  bool uploading = false;
  String? updateState;
  String _selectedAIProvider = 'Local';
  List<String> aiProviders = const ['Local', 'AWS'];

  @override
  void initState() {
    super.initState();
    if (widget.initialTitle != null) title.text = widget.initialTitle!;
    if (widget.initialAuthor != null) author.text = widget.initialAuthor!;
    if (widget.initialPriceCents != null) {
      price.text = widget.initialPriceCents!.toString();
    }
  }

  Future<void> _pick() async {
    if (!widget.forceStatus! &&
        ((widget.resumeStatus ?? shoppb.MediaStatus.MEDIA_STATUS_UNSPECIFIED) !=
            shoppb.MediaStatus.MEDIA_STATUS_UNSPECIFIED)) {
      return;
    }

    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'm4a', 'wav'],
    );
    if (res != null && res.files.single.path != null) {
      setState(() => pickedPath = res.files.single.path!);
    }
  }


  String _mimeFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.mp3')) return 'audio/mpeg';
    if (lower.endsWith('.m4a')) return 'audio/mp4';
    if (lower.endsWith('.wav')) return 'audio/wav';
    return 'application/octet-stream';
  }

  Future<void> _uploadAndComplete(shoppb.MediaStatus? forceStatus) async {
    try {
      setState(() {
        status =
            widget.isResume ? 'Resuming upload…' : 'Requesting upload URL…';
      });

      shoppb.MediaStatus? currentStatus;
      
      if(widget.resumeStatus != null){
        currentStatus = widget.resumeStatus;
      } 

      if(forceStatus != null) {
        currentStatus = forceStatus;
      }

      late final String uploadUrl;
      late final String audiobookId;

      if (widget.isResume) {
        uploadUrl = widget.resumeUploadUrl!;
        audiobookId = widget.resumeAudiobookId!;
      } else {
        if (pickedPath == null) {
          if (!mounted) return;
          setState(() => status = 'Pick a file first');
          return;
        }
        setState(() {
          uploading = true;
          status = 'Requesting...';
        });

        final filename = pickedPath!.split(Platform.pathSeparator).last;
        final ct = _mimeFromName(filename);
        final up = await widget.shopApi.createUploadURL(
          title: title.text,
          author: author.text,
          priceCents: int.tryParse(price.text) ?? 0,
          filename: filename,
          contentType: ct,
        );
        uploadUrl = up.uploadUrl;
        audiobookId = up.audiobookId;
      }

      if (currentStatus == null || currentStatus == shoppb.MediaStatus.MEDIA_STATUS_UNSPECIFIED || currentStatus == shoppb.MediaStatus.MEDIA_PROCESSING_AUDIO) {

        if (pickedPath == null) {
          if (!mounted) return;
          setState(() => status = 'Pick a file first');
          return;
        }

        setState(() {
          uploading = true;
          status = 'Uploading...';
        });

        final file = File(pickedPath!);
        final filename = pickedPath!.split(Platform.pathSeparator).last;
        final ct = _mimeFromName(filename);
        final uploadFullUrl = "http://${widget.host}:25213$uploadUrl";
        final put = await http.put(Uri.parse(uploadFullUrl),
            headers: {'Content-Type': ct}, body: await file.readAsBytes());
        if (put.statusCode != 200 && put.statusCode != 201) {
          if (!mounted) return;
          setState(() {
            uploading = false;
            status = 'Upload failed: HTTP ${put.statusCode}';
          });
          return;
        }
      }

      // ----- Fire-and-poll -----
      if (!mounted) return;
      setState(() {
        uploading = true;
        status = 'Processing...';
      });

      dynamic completeUploadError;
      final inflight = widget.shopApi
          .completeUpload(audiobookId, _selectedAIProvider == "Local" ? shoppb.AIProvider.AIProvider_LOCAL : shoppb.AIProvider.AIProvider_AWS, currentStatus ?? shoppb.MediaStatus.MEDIA_STATUS_UNSPECIFIED)
          .timeout(const Duration(seconds: 180));
      unawaited(inflight.then((_) {}).catchError((e, stack) {
        completeUploadError = e;
      }));

      final started = DateTime.now();
      const pollEvery = Duration(seconds: 2);
      const maxWait = Duration(minutes: 10);
      shoppb.MediaStatus? lastShown;

      while (mounted) {
        await Future.delayed(pollEvery);

        if (!mounted) return;

        if (completeUploadError != null) {
          setState(() => status = 'Conection failure');
          uploading = false;
          break;
        }

        if (DateTime.now().difference(started) > maxWait) {
          setState(() => status = 'Timed out while processing');
          uploading = false;
          break;
        }

        if (!mounted) return;

        final st = await widget.shopApi.getAudiobookStatus(audiobookId);

        if (st.status != lastShown) {
          lastShown = st.status;
          switch (st.status) {
            case shoppb.MediaStatus.MEDIA_PROCESSING_AUDIO:
              setState(() => status = 'Processing Audio File...');
              break;
            case shoppb.MediaStatus.MEDIA_PROCESSING_TRANSCRIPT:
              setState(() => status = 'Processing Transcript...');
              break;
            case shoppb.MediaStatus.MEDIA_PROCESSING_SUMMARY:
              setState(() => status = 'Processing Summary...');
              break;
            case shoppb.MediaStatus.MEDIA_READY:
              setState(() {
                uploading = false;
                status = 'Complete!';
              });
              return;
            default:
              setState(() => status = 'waiting…');
          }
        } else {
          final dotCount = status.split(".").length;
          if (dotCount >= 4) {
            setState(() => status = status.replaceAll("...", "."));
          } else if (dotCount >= 3) {
            setState(() => status = status.replaceAll("..", "..."));
          } else if (dotCount >= 2) {
            setState(() => status = status.replaceAll(".", ".."));
          }
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        uploading = false;
        status = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isResume = widget.isResume;
    return Scaffold(
      appBar:
          AppBar(title: Text(isResume ? widget.forceStatus! ? 'Update Audiobook' : 'Resume Upload' :  'Create Audiobook')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                Text("AI Provider", style: TextStyle(fontSize: 18),),
                const SizedBox(width: 30,),
            DropdownMenu<String>(
                      initialSelection: _selectedAIProvider,
                      dropdownMenuEntries: aiProviders
                          .map((c) => DropdownMenuEntry(value: c, label: c))
                          .toList(),
                      onSelected: (v) =>
                          setState(() => _selectedAIProvider = v ?? 'Local'),
                      menuHeight: 200,
                      inputDecorationTheme: InputDecorationTheme(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        constraints:
                            BoxConstraints.tight(const Size.fromHeight(40)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(28, 0, 0, 0))),
                      ),
                      menuStyle: MenuStyle(
                        alignment: Alignment.bottomLeft,
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                            side: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 8),
            TextField(
                controller: author,
                decoration: const InputDecoration(labelText: 'Author')),
            const SizedBox(height: 8),
            TextField(
                controller: price,
                decoration: const InputDecoration(labelText: 'Price (cents)')),
            const SizedBox(height: 8),
            Row(children: [
              ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  onPressed: _pick,
                  child: Text(
                    'Pick audio',
                    style: TextStyle(
                        color: (!widget.forceStatus! &&
                                (widget.resumeStatus ??
                                        shoppb.MediaStatus
                                            .MEDIA_STATUS_UNSPECIFIED) !=
                                    shoppb.MediaStatus.MEDIA_STATUS_UNSPECIFIED)
                            ? const Color.fromARGB(255, 151, 150, 150)
                            : null),
                  )),
              const SizedBox(width: 8),
              Expanded(child: Text(pickedPath ?? 'No file')),
            ]),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: widget.forceStatus!
                  ? Column(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide.none,
                              ),
                            ),
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return uploading
                                  ? const Color.fromARGB(255, 151, 150, 150)
                                  : null;
                            }),
                          ),
                          onPressed: () {
                            if (!uploading) {
                              _uploadAndComplete(shoppb.MediaStatus.MEDIA_PROCESSING_AUDIO);
                            }
                          },
                          child: Text("Upload"),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide.none,
                              ),
                            ),
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return uploading
                                  ? const Color.fromARGB(255, 151, 150, 150)
                                  : null;
                            }),
                          ),
                          onPressed: () {
                            if (!uploading) {
                              _uploadAndComplete(shoppb.MediaStatus.MEDIA_PROCESSING_TRANSCRIPT);
                            }
                          },
                          child: Text("Transcript"),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide.none,
                              ),
                            ),
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return uploading
                                  ? const Color.fromARGB(255, 151, 150, 150)
                                  : null;
                            }),
                          ),
                          onPressed: () {
                            if (!uploading) {
                              _uploadAndComplete(shoppb.MediaStatus.MEDIA_PROCESSING_SUMMARY);
                            }
                          },
                          child: Text("Description"),
                        ),
                      ],
                    )
                  : Column(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide.none,
                              ),
                            ),
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return uploading
                                  ? const Color.fromARGB(255, 151, 150, 150)
                                  : null;
                            }),
                          ),
                          onPressed: () {
                            if (!uploading) {
                              _uploadAndComplete(null);
                            }
                          },
                          child: Text(isResume
                              ? 'Resume & Complete'
                              : 'Upload & Complete'),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            Text('Status: $status'),
          ],
        ),
      ),
    );
  }
}
