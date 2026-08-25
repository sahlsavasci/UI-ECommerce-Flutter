import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // Mengubah navigasi agar kembali ke halaman sebelumnya
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Cart',
              style: TextStyle(
                color: Color(0xFF4C53A5),
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          // Mengganti Icon biasa dengan PopupMenuButton
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
            onSelected: (value) {
              // Menampilkan SnackBar visual untuk aksi menu
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
