import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/api/shop_api.dart';
import 'package:frontend/token_store.dart';
import 'package:frontend/api/auth_api.dart';
import 'package:frontend/pages/shop/shop_catalog.dart';
import 'package:frontend/pages/shop/cart.dart';
import 'package:frontend/pages/shop/purchases.dart';
import 'package:frontend/pages/shop/create_audiobook.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
    required this.host,
    required this.port,
    required this.useGrpcWeb,
    required this.accessToken,
    required this.isAdmin,
    required this.userEmail,
  });

  final String host;
  final int port;
  final bool useGrpcWeb;
  final String accessToken;
  final bool isAdmin;
  final String userEmail;

  @override
  State<ShopPage> createState() => _ShopPageState();
}


class _ShopPageState extends State<ShopPage> {
  late final ShopApi shopApi;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    shopApi = createShopApi(
      widget.host,
      widget.port,
      accessToken: widget.accessToken,
      useGrpcWeb: widget.useGrpcWeb,
    );
  }

  Future<void> _logout() async {
    try {
      final saved = await TokenStore.load();
      final refresh = saved.refresh;
      if (refresh != null && refresh.isNotEmpty) {
        final authApi = AuthApi(widget.host, widget.port);
        await authApi.revoke(refresh);
        await authApi.close();
      }
    } catch (_) {

    }

    await TokenStore.clear();

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    unawaited(shopApi.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      CatalogPage(
        shopApi: shopApi,
        isAdmin: widget.isAdmin,
        host: widget.host,
      ),
      CartPage(shopApi: shopApi),
      PurchasesPage(shopApi: shopApi, host: widget.host,),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 237, 237),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 237, 237),
        title: Text('Shop (${widget.userEmail})'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 239, 237, 237),
        currentIndex: tab,
        onTap: (i) => setState(() => tab = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: 'Catalog'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Purchases'),
        ],
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      CreateAudioBookPage(shopApi: shopApi, host: widget.host, forceStatus: false,),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}