import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_bottom_navbar.dart';
import '../widgets/cart_item_samples.dart';

class CartPage extends StatefulWidget {
  final bool isEmbedded;
  final bool hideBottomBar;
  const CartPage({super.key, this.isEmbedded = false, this.hideBottomBar = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _couponController = TextEditingController();

  @override
  void dispose() { _couponController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final hasSelected = context.watch<CartProvider>().items.any((item) => item.isSelected);
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(child: Column(children: [
        CartAppBar(showBackButton: !widget.isEmbedded && Navigator.canPop(context)),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const SizedBox(height: 16),
            const CartItemSamples(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _couponController, decoration: InputDecoration(hintText: 'Kode kupon', hintStyle: const TextStyle(color: AppTheme.textSecondary), prefixIcon: const Icon(Icons.local_offer_outlined, color: AppTheme.textSecondary), border: InputBorder.none))),
                  const SizedBox(width: 12),
                  ElevatedButton(onPressed: () {
                    if (_couponController.text.trim().isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kupon "${_couponController.text.trim()}" berhasil!')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan kode kupon terlebih dahulu')));
                    }
                  }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text('Terapkan')),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ]),
        )),
        if (!widget.hideBottomBar)
          CartBottomNavbar(
            onCheckout: hasSelected
                ? (widget.isEmbedded ? () => Navigator.pushNamed(context, 'CheckoutPage') : null)
                : null,
          ),
      ])),
    );
  }
}
