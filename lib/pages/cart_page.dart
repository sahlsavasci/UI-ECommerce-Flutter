import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_bottom_navbar.dart';
import '../widgets/cart_item_samples.dart';

class CartPage extends StatefulWidget {
  final bool isEmbedded;
  const CartPage({super.key, this.isEmbedded = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CartAppBar(
              showBackButton: !widget.isEmbedded && Navigator.canPop(context),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: ListView(
                  children: [
                    const CartItemSamples(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Input TextField coupon
                          Expanded(
                            child: TextField(
                              controller: _couponController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Kode Kupon',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Coupon apply button
                          ElevatedButton(
                            onPressed: () {
                              if (_couponController.text.trim().isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Kupon "${_couponController.text.trim()}" berhasil diterapkan!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Silakan masukkan kode kupon terlebih dahulu'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomNavbar(),
    );
  }
}