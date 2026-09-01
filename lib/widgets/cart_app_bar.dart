import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CartAppBar extends StatelessWidget {
  final bool showBackButton;
  const CartAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      color: Colors.white,
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: AppTheme.textPrimary,
              onPressed: () => Navigator.pop(context),
            ),
          if (showBackButton) const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Keranjang Belanja',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, size: 24),
            color: Colors.white,
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Aksi: $value')),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Clear', child: Text('Bersihkan Keranjang')),
              const PopupMenuItem(value: 'Share', child: Text('Bagikan Keranjang')),
            ],
          ),
        ],
      ),
    );
  }
}
