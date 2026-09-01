import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = <Map<String, dynamic>>[
      {'name': 'Fashion', 'icon': Icons.checkroom},
      {'name': 'Food', 'icon': Icons.fastfood},
      {'name': 'Beauty', 'icon': Icons.face},
      {'name': 'Tech', 'icon': Icons.mobile_friendly},
      {'name': 'Shoes', 'icon': Icons.directions_run},
      {'name': 'Books', 'icon': Icons.menu_book},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(categories.length, (i) {
          final cat = categories[i];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < categories.length - 1 ? 6 : 0),
              child: _CategoryPill(name: cat['name']!, icon: cat['icon'] as IconData),
            ),
          );
        }),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String name;
  final IconData icon;
  const _CategoryPill({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.border)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 22, color: AppTheme.primary),
            const SizedBox(height: 4),
            Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)),
          ]),
        ),
      ),
    );
  }
}
