import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top row: location + delivery mode
        Row(children: [
          _LocationChip(icon: Icons.location_on_outlined, label: 'Town Hall', onTap: () {}),
          const SizedBox(width: 8),
          _LocationChip(icon: Icons.access_time, label: 'Open until 11:59pm', onTap: () {}),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'ListChat'),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.chat_bubble_outline, size: 20, color: AppTheme.primary),
            ),
          ),
        ]),
        const SizedBox(height: 10),
        // Store mode toggle
        Row(children: [
          _ModeChip(label: 'Pick Up', active: false, onTap: () {}),
          const SizedBox(width: 8),
          _ModeChip(label: 'Delivery', active: false, onTap: () {}),
          const SizedBox(width: 8),
          _ModeChip(label: 'In-store', active: true, onTap: () {}),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.loyalty, size: 14, color: AppTheme.primary),
              SizedBox(width: 4),
              Text('850', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primary)),
              SizedBox(width: 2),
              Text('/ 2000', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
            ]),
          ),
        ]),
      ]),
    );
  }
}

class _LocationChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _LocationChip({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: AppTheme.primary),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        const Icon(Icons.arrow_drop_down, size: 18, color: AppTheme.textSecondary),
      ])),
    ),
  );
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ModeChip({required this.label, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? AppTheme.primary : AppTheme.border),
        ),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.w500, color: active ? Colors.white : AppTheme.textSecondary)),
      ),
    ),
  );
}
