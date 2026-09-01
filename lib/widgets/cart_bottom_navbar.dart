import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class CartBottomNavbar extends StatelessWidget {
  final VoidCallback? onCheckout;
  const CartBottomNavbar({super.key, this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final selectedItems = cartProvider.items.where((item) => item.isSelected).toList();
    final selectedTotal = selectedItems.fold<double>(0, (sum, item) => sum + (item.product.discountedPrice * item.quantity));

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${selectedItems.length} item dipilih', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                      const SizedBox(height: 2),
                      const Text('Total:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ]),
                    Text('\$${selectedTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedItems.isEmpty || onCheckout == null ? null : onCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: const Text('Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
