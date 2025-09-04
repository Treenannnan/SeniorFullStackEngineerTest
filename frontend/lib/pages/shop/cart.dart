import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/api/shop_api.dart';
import 'package:frontend/proto/shop/v1/shop.pbgrpc.dart' as shoppb;
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:frontend/widget/square_icon.dart';

String fmtBahtFromCents($fixnum.Int64 v) =>
    (v.toInt() / 100).toStringAsFixed(2);

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.shopApi});
  final ShopApi shopApi;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  shoppb.ViewCartResponse? cart;
  String status = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => status = 'Loading…');
    try {
      final resp = await widget.shopApi.viewCart();
      setState(() {
        cart = resp;
        status = 'OK';
      });
    } catch (e) {
      setState(() => status = 'Error: $e');
    }
  }

  Future<void> _checkout() async {
    try {
      final resp = await widget.shopApi.checkout();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Paid ฿${fmtBahtFromCents(resp.totalCents)} (Order ${resp.orderId})')),
        );
      }
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Checkout failed: $e')));
      }
    }
  }

  Future<void> _delItem(shoppb.CartItem it) async {
    try {
      await widget.shopApi.removeFromCart(it.book.id, quantity: 1);
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Remove ${it.book.title} success')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Remove failed: $e')));
    }
  }
/*
  Widget _delAudiobook(IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        icon: Icon(icon, size: 20),
        padding: EdgeInsets.zero,
        splashRadius: 18,
        onPressed: onTap,
      ),
    );
  }
*/
  Future<void> _description(String id) async {
    try {
      final resp = await widget.shopApi.getDescription(id);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Description'),
          content: SingleChildScrollView(child: Text(resp.description)),
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
    final items = cart?.items ?? [];
    final totalText = cart?.subtotalCents != null
        ? fmtBahtFromCents(cart!.subtotalCents)
        : '0.00';

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        itemCount: (items.isEmpty ? 2 : items.length + 2),
        itemBuilder: (ctx, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: items.isEmpty ? null : _checkout,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Checkout')),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('Total: ฿$totalText',
                          style: Theme.of(context).textTheme.titleMedium),
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

          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Your cart is empty.\nPull down to refresh.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          final it = items[i - 2];
          it.book.categories.sort((String a, String b) {
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
                title: Text(it.book.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(it.book.author),
                        const SizedBox(width: 20),
                        squareIconButton(Icons.subject, () {
                          _description(it.book.id);
                        }, 30, const Color.fromARGB(255, 255, 255, 255))
                      ],
                    ),
                    it.book.categories.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Wrap(
                              spacing: 6,
                              children: it.book.categories
                                  .map<Widget>((String t) => Chip(
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
                  height: 200,
                  child: Transform.translate(
                    offset: Offset(0, 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        squareIconButton(Icons.delete, () {
                          _delItem(it);
                        }, 20, Colors.black),
                        const SizedBox(height: 10),
                        Text('\$${fmtBahtFromCents(it.book.priceCents)}',
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


/*
children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 7, 16, 0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: items.isEmpty ? null : _checkout,
                    child: const Text('Checkout')),
                const SizedBox(width: 12),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Total: ฿$totalText',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Your cart is empty.\nPull down to refresh.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          else
            ...items.map((it) => ListTile(
                  title: Text(it.book.title),
                  subtitle: Text(
                      '${it.book.author} • ฿${fmtBahtFromCents(it.book.priceCents)} x ${it.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _delBtn(Icons.remove, () => _delItem(it)), // << กดลบ 1
                    ],
                  ),
                )),
          const Divider(),
        ],
*/