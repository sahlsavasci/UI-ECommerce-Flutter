import 'package:e_commerce/widgets/CartAppBar.dart';
import 'package:e_commerce/widgets/CartBottomNavbar.dart';
import 'package:e_commerce/widgets/CartItemSamples.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const CartAppBar(),
          Container(
            height: 700,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35)
              ),
            ),
            child: Column(
              children: [
                const CartItemSamples(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // Input TextField untuk memasukkan kode kupon
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Masukkan Kode Kupon',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Tombol Apply visual
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kupon berhasil diterapkan!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C53A5),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:const CartBottomNavbar(),
    );
  }
}