import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/api/shop_api.dart';
import 'package:frontend/proto/shop/v1/shop.pbgrpc.dart' as shoppb;
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:file_saver/file_saver.dart';
import 'package:frontend/widget/square_icon.dart';
import 'package:http/http.dart' as http;

String fmtBahtFromCents($fixnum.Int64 v) =>
    (v.toInt() / 100).toStringAsFixed(2);

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key, required this.shopApi, required this.host});
  final ShopApi shopApi;
  final String host;

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  List<shoppb.ListPurchasesResponse_PurchasedItem> items = [];
  String status = '';
  String _selectedCategory = 'All';
  List<String> _categories = const ['All'];
  List<shoppb.ListPurchasesResponse_PurchasedItem> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final resp = await widget.shopApi.listPurchases();
      setState(() {
        items = resp.items;
        status = 'OK';
      });

      final setCats = <String>{};
      for (final a in resp.items) {
        for (final t in a.book.categories) {
          if (t.trim().isNotEmpty) setCats.add(t.trim());
        }
      }
      final cats = [
        'All',
        ...setCats.toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()))
      ];

      setState(() {
        _items = resp.items;
        _categories = cats;
        if (!_categories.contains(_selectedCategory)) {
          _selectedCategory = 'All';
        }
      });
    } catch (e) {
      setState(() => status = 'Error: $e');
    }
  }

  Future<void> _download(String id, String title) async {
    try {
      final resp = await widget.shopApi.getDownloadURL(id);
      final url = resp.downloadUrl;
      final fileName = url.split("/")[url.split("/").length - 1];
      final bytes = await http.readBytes(Uri.parse(url));
      final f = await FileSaver.instance.saveAs(
        name: fileName,
        bytes: bytes,
        fileExtension: 'mp3',
        mimeType: MimeType.mp3,
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Download to : $f')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  List<shoppb.ListPurchasesResponse_PurchasedItem> _visibleItems() {
    Iterable<shoppb.ListPurchasesResponse_PurchasedItem> list = _items;
    if (_selectedCategory != 'All') {
      list = list.where((a) => a.book.categories.contains(_selectedCategory));
    }

    final sorted = list.toList();
    return sorted;
  }

  Future<void> _description(String id) async {
    try {
      final resp = await widget.shopApi.getDescription(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Description'),
          content: SingleChildScrollView(child: Text(resp.description)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }

  Future<void> _transcript(String id) async {
    try {
      final resp = await widget.shopApi.getTranscript(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Transcript'),
          content: SingleChildScrollView(child: Text(resp.transcript)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vis = _visibleItems();
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: (vis.isEmpty ? 2 : vis.length + 2),
        itemBuilder: (ctx, i) {
          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            );
          }

          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(5, 0, 20, 0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    DropdownMenu<String>(
                      initialSelection: _selectedCategory,
                      dropdownMenuEntries: _categories
                          .map((c) => DropdownMenuEntry(value: c, label: c))
                          .toList(),
                      onSelected: (v) =>
                          setState(() => _selectedCategory = v ?? 'All'),
                      menuHeight: 240,
                      width: 250,
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
                    ),
                  ],
                ),
              ),
            );
          }
          if (i == 1) {
            return const Divider(
              height: 2,
            );
          }
          final p = vis[i - 2];
          p.book.categories.sort((a, b) {
            return a.toLowerCase().compareTo(b.toLowerCase());
          });
          return Card(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color.fromARGB(255, 35, 35, 35),
                    const Color.fromARGB(255, 255, 255, 255),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: ListTile(
                titleTextStyle: TextStyle(
                    color: const Color.fromARGB(255, 238, 224, 224),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                subtitleTextStyle: TextStyle(
                  height: 2,
                  color: Colors.white,
                  fontSize: 12,
                ),
                title: Text(p.book.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.book.author),
                        const SizedBox(width: 20),
                        squareIconButton(Icons.subject, () {
                          _description(p.book.id);
                        }, 30, const Color.fromARGB(255, 255, 255, 255))
                      ],
                    ),
                    p.book.categories.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Wrap(
                              spacing: 6,
                              children: p.book.categories
                                  .map((t) => Chip(
                                      labelPadding: EdgeInsets.all(0),
                                      label: Text(
                                        t,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      visualDensity: VisualDensity.compact))
                                  .toList(),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const SizedBox(height: 25),
                          )
                  ],
                ),
                trailing: SizedBox(
                  child: Transform.translate(
                    offset: Offset(0, -21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${p.purchasedAt.toDateTime().toLocal()}',
                            style: const TextStyle(fontSize: 8)),
                        const SizedBox(height: 8),
                        Wrap(spacing: 8, children: [
                          squareIconButton(Icons.download, () {
                            _download(p.book.id, p.book.title);
                          }, 30, const Color.fromARGB(255, 0, 0, 0)),
                          squareIconButton(Icons.book, () {
                            _transcript(p.book.id);
                          }, 30, const Color.fromARGB(255, 0, 0, 0))
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          /*
          return Card(
            child: ListTile(
              title: Text(p.book.title),
              subtitle: Text(
                  '฿${fmtBahtFromCents(p.priceCents)} • ${p.purchasedAt.toDateTime().toLocal()}'),
              trailing: Wrap(spacing: 8, children: [
                IconButton(
                    onPressed: () => _description(p.book.id),
                    icon: const Icon(Icons.subject)),
                IconButton(
                    onPressed: () => _download(p.book.id, p.book.title),
                    icon: const Icon(Icons.download)),
                IconButton(
                    onPressed: () => _transcript(p.book.id),
                    icon: const Icon(Icons.book)),
              ]),
            ),
          );
          */
        },
      ),
    );
  }
}
