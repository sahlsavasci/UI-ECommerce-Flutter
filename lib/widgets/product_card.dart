import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Image area
        Stack(children: [
          InkWell(
            onTap: onTap ?? () => Navigator.pushNamed(context, 'itemsPage'),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
              child: Center(child: Image.asset(product.imagePath, height: 80, fit: BoxFit.contain, errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported, size: 36, color: Colors.grey))),
            ),
          ),
          if (product.discountPercent > 0)
            Positioned(
              top: 6, left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppTheme.accentRed, borderRadius: BorderRadius.circular(6)),
                child: const Text('SALE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          Positioned(top: 6, right: 6, child: _HeartBtn()),
        ]),
        // Content
        Expanded(
          child: Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Category pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(product.category, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppTheme.primary)),
            ),
            const SizedBox(height: 4),
            // Title
            Flexible(child: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary))),
            const Spacer(),
            // Price
            Row(children: [
              Text('\$${product.discountedPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              if (product.discountPercent > 0) ...[
                const SizedBox(width: 4),
                Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10, color: AppTheme.textMuted, decoration: TextDecoration.lineThrough)),
              ],
            ]),
            // Unit price
            Text('\$${(product.discountedPrice).toStringAsFixed(2)} per unit', style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
            const SizedBox(height: 6),
            // Add to cart button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.title} masuk keranjang!'), duration: const Duration(seconds: 1)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                child: const Text('+ Add to Cart'),
              ),
            ),
            const SizedBox(height: 4),
            // In Stock badge
            Row(children: [
              const Icon(Icons.check_circle, size: 14, color: AppTheme.success),
              const SizedBox(width: 4),
              const Text('In Stock', style: TextStyle(fontSize: 11, color: AppTheme.success)),
            ]),
          ])),
        ),
      ]),
    );
  }
}

class _HeartBtn extends StatelessWidget {
  const _HeartBtn();
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.favorite_border, size: 18, color: Colors.grey)),
    ),
  );
}
