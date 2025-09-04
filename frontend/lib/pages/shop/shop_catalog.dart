import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/api/shop_api.dart';
import 'create_audiobook.dart';
import 'package:frontend/proto/shop/v1/shop.pbgrpc.dart' as shoppb;
import 'package:frontend/widget/square_icon.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;

String fmtBahtFromCents($fixnum.Int64 v) =>
    (v.toInt() / 100).toStringAsFixed(2);

class CatalogPage extends StatefulWidget {
  const CatalogPage(
      {super.key,
      required this.shopApi,
      required this.isAdmin,
      required this.host});
  final ShopApi shopApi;
  final bool isAdmin;
  final String host;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<shoppb.Audiobook> _items = [];
  List<shoppb.ListPurchasesResponse_PurchasedItem> pItems = [];

  shoppb.ViewCartResponse? cart;
  String status = '';
  String _selectedCategory = 'All';
  bool _sortAsc = true;
  List<String> _categories = const ['All'];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _load() async {
    try {
      final resp = await widget.shopApi.listPurchases();
      setState(() {
        pItems = resp.items;
      });
      final respc = await widget.shopApi.viewCart();
      setState(() {
        cart = respc;
      });
    } catch (_) {}
  }

  bool _purchasesContains(String audioId) {
    for (final a in pItems) {
      if (a.book.id == audioId) {
        return true;
      }
    }
    return false;
  }

  bool _cartContains(String audioId) {
    if (cart == null) {
      return false;
    }

    for (final a in cart!.items) {
      if (a.book.id == audioId) {
        return true;
      }
    }
    return false;
  }

  Future<void> _refresh() async {
    try {
      await _load();

      final resp = await widget.shopApi.listAudiobooks(pageSize: 200);
      List<shoppb.Audiobook> items = [];

      final setCats = <String>{};
      for (final a in resp.items) {
        if (_purchasesContains(a.id) && !widget.isAdmin) {
          continue;
        }

        for (final t in a.categories) {
          if (t.trim().isNotEmpty) setCats.add(t.trim());
        }

        items.add(a);
      }
      final cats = [
        'All',
        ...setCats.toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()))
      ];

      setState(() {
        _items = items;
        _categories = cats;
        if (!_categories.contains(_selectedCategory)) {
          _selectedCategory = 'All';
        }
      });
    } catch (_) {}
  }

  Future<void> _add(String id) async {
    try {
      await widget.shopApi.addToCart(id);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Added to cart')));
      }

      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  Future<void> _continueUpload(shoppb.Audiobook a, bool forceStatus) async {
    try {
      final up = await widget.shopApi.getUploadURLForExisting(a.id);
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CreateAudioBookPage(
            host: widget.host,
            shopApi: widget.shopApi,
            initialTitle: a.title,
            initialAuthor: a.author,
            initialPriceCents: a.priceCents.toInt(),
            resumeAudiobookId: up.audiobookId,
            resumeUploadUrl: up.uploadUrl,
            resumeStatus: a.status,
            forceStatus: forceStatus
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Resume failed: $e')));
    }
  }

  List<shoppb.Audiobook> _visibleItems() {
    Iterable<shoppb.Audiobook> list = _items;
    if (_selectedCategory != 'All') {
      list = list.where((a) => a.categories.contains(_selectedCategory));
    }

    final sorted = list.toList()
      ..sort((a, b) {
        final cmp = a.priceCents.compareTo(b.priceCents);
        return _sortAsc ? cmp : -cmp;
      });
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

  @override
  Widget build(BuildContext context) {
    final vis = _visibleItems();
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: (vis.isEmpty ? 2 : vis.length + 2),
        itemBuilder: (ctx, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 0),
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
                    DropdownMenu<bool>(
                      initialSelection: _sortAsc,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: true, label: 'ราคา: ต่ำ→สูง'),
                        DropdownMenuEntry(value: false, label: 'ราคา: สูง→ต่ำ'),
                      ],
                      onSelected: (v) => setState(() => _sortAsc = v ?? true),
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
                      alignmentOffset: const Offset(0, 8),
                      menuHeight: 180,
                    )
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

          if (vis.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('No items. Pull down to refresh.'),
            );
          }

          shoppb.Audiobook a = vis[i - 2];
          a.categories.sort((a, b) {
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
                title: Text(a.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.author),
                        const SizedBox(width: 20),
                        squareIconButton(Icons.subject, () {
                          _description(a.id);
                        }, 30, const Color.fromARGB(255, 255, 255, 255))
                      ],
                    ),
                    a.categories.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Wrap(
                              spacing: 6,
                              children: a.categories
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
                            child: const SizedBox(height: 40),
                          )
                  ],
                ),
                trailing: Stack(
                  children: [Transform.translate(
                    offset: Offset(0, -21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${fmtBahtFromCents(a.priceCents)}',
                            style: const TextStyle(fontSize: 15)),
                        const SizedBox(height: 8),
                        if (!widget.isAdmin &&
                            a.status == shoppb.MediaStatus.MEDIA_READY &&
                            _cartContains(a.id))
                          squareIconButton(Icons.shopping_cart_checkout, () {},
                              20, Colors.black)
                        else if (!widget.isAdmin &&
                            a.status == shoppb.MediaStatus.MEDIA_READY)
                          squareIconButton(Icons.add_shopping_cart, () => _add(a.id),20, Colors.black)
                        else if (widget.isAdmin &&
                            a.status == shoppb.MediaStatus.MEDIA_READY)
                          squareIconButton(Icons.add_shopping_cart, () => _add(a.id),20, Colors.black)
                          
                        else if (widget.isAdmin &&
                            (a.status ==
                                    shoppb.MediaStatus.MEDIA_PROCESSING_AUDIO ||
                                a.status ==
                                    shoppb.MediaStatus
                                        .MEDIA_PROCESSING_TRANSCRIPT ||
                                a.status ==
                                    shoppb
                                        .MediaStatus.MEDIA_PROCESSING_SUMMARY ||
                                a.status ==
                                    shoppb
                                        .MediaStatus.MEDIA_STATUS_UNSPECIFIED))
                          squareIconButton(Icons.upload_file,
                              () => _continueUpload(a, false), 20, Colors.black),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(39, 40),
                    child: widget.isAdmin && a.status == shoppb.MediaStatus.MEDIA_READY
                    ? squareIconButton(Icons.recycling_outlined,
                              () => _continueUpload(a, true), 20, Colors.black)
                              : const SizedBox()
                  ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
