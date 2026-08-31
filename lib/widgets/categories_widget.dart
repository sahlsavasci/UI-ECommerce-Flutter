import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Outfit',
      'Makanan',
      'Skincare',
      'Electronic',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/categories/${i + 1}.png',
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.category,
                      size: 30,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    categories[i],
                    style: AppTheme.heading3.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
