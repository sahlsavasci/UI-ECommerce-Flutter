import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CartAppBar extends StatelessWidget {
  final bool showBackButton;
  const CartAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          if (showBackButton) ...[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Cart',
              style: AppTheme.heading2,
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 28,
              color: AppTheme.primaryColor,
            ),
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Aksi terpilih: $value')),
              );
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Clear Cart',
                  child: Text('Bersihkan Keranjang'),
                ),
                const PopupMenuItem<String>(
                  value: 'Share Cart',
                  child: Text('Bagikan Keranjang'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
