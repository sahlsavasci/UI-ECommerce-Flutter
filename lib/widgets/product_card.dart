import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() => _isLiked = !_isLiked);
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cartProvider = context.read<CartProvider>();
    final discount = product.discountPercent > 0;
    final inCart = cartProvider.items.any((ci) => ci.product.id == product.id);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) => Transform.scale(
        scale: 0.95 + (0.05 * value),
        child: Opacity(opacity: value, child: child),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border, width: 1),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image area
          Stack(children: [
            InkWell(
              onTap: widget.onTap ?? () => Navigator.pushNamed(context, 'itemsPage'),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                child: Center(child: Image.asset(product.imagePath, height: 90, fit: BoxFit.contain, errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported, size: 36, color: Colors.grey))),
              ),
            ),
            if (discount)
              Positioned(
                top: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: AppTheme.accentRed, borderRadius: BorderRadius.circular(6)),
                  child: Text('-${product.discountPercent}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            Positioned(
              top: 8, right: 8,
              child: AnimatedScale(
                scale: _isLiked ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _toggleLike,
                    child: Padding(padding: const EdgeInsets.all(6), child: Icon(_isLiked ? Icons.favorite : Icons.favorite_border, size: 18, color: _isLiked ? AppTheme.accentRed : Colors.grey)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8, right: 8,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => cartProvider.addToCart(product),
                  child: Padding(padding: const EdgeInsets.all(6), child: Icon(inCart ? Icons.check : Icons.add_shopping_cart, size: 18, color: inCart ? AppTheme.success : AppTheme.primary)),
                ),
              ),
            ),
          ]),
          // Content
          Expanded(
            child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(product.category, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppTheme.primary)),
              ),
              const SizedBox(height: 6),
              Flexible(child: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary))),
              const Spacer(),
              Row(children: [
                Text('\$${product.discountedPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                if (discount) ...[
                  const SizedBox(width: 4),
                  Text('\$${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, decoration: TextDecoration.lineThrough)),
                ],
              ]),
              const SizedBox(height: 8),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('+ Add to Cart'),
                ),
              ),
            ])),
          ),
        ]),
      ),
    );
  }
}
