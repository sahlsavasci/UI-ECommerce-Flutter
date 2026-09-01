import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int? cartBadge;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartBadge,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = <_NavItemData>[
      _NavItemData(icon: Icons.home, label: 'Home', isActive: currentIndex == 0),
      _NavItemData(icon: Icons.shopping_cart_outlined, label: 'Cart', isActive: currentIndex == 1, badge: cartBadge),
      _NavItemData(icon: Icons.person_outline, label: 'Account', isActive: currentIndex == 2),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              final index = navItems.indexOf(item);
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: _NavTile(item: item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  final bool isActive;
  final int? badge;
  const _NavItemData({
    required this.icon,
    required this.label,
    required this.isActive,
    this.badge,
  });
}

class _NavTile extends StatelessWidget {
  final _NavItemData item;
  const _NavTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Animated circular background
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: item.isActive ? 44 : 0,
              height: item.isActive ? 44 : 0,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
            ),
            // Single icon — fades and scales between active/inactive
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: item.isActive ? 1.0 : 1.0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: item.isActive ? 1.1 : 1.0,
                child: Icon(
                  item.icon,
                  size: 24,
                  color: item.isActive ? AppTheme.primary : AppTheme.textSecondary,
                ),
              ),
            ),
            // Badge
            if (item.badge != null && item.badge! > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    item.badge! >= 100 ? '99+' : '${item.badge}',
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 3),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 11,
            fontWeight: item.isActive ? FontWeight.w700 : FontWeight.w400,
            color: item.isActive ? AppTheme.primary : AppTheme.textSecondary,
          ),
          child: Text(item.label),
        ),
      ],
    );
  }
}
