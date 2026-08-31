import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_card.dart';

class ItemsWidget extends StatelessWidget {
  ItemsWidget({super.key});

  final List<Product> products = [
    const Product(
      id: '1',
      title: 'Outfit Sport',
      description: 'Comfortable outfit set for sports and daily workouts',
      price: 65.0,
      discountPercent: 58,
      imagePath: 'images/items/1.png',
      category: 'Outfit',
    ),
    const Product(
      id: '2',
      title: 'Makanan Ringan',
      description: 'Healthy delicious snacks for your active daily life',
      price: 35.0,
      discountPercent: 40,
      imagePath: 'images/items/2.png',
      category: 'Makanan',
    ),
    const Product(
      id: '3',
      title: 'Skincare Glow',
      description: 'Hydrating skincare formula for radiant healthy skin',
      price: 80.0,
      discountPercent: 30,
      imagePath: 'images/items/3.png',
      category: 'Skincare',
    ),
    const Product(
      id: '4',
      title: 'Electronic Gadget',
      description: 'Next-generation smart portable gadget for everyday tech',
      price: 120.0,
      discountPercent: 25,
      imagePath: 'images/items/4.png',
      category: 'Electronic',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
