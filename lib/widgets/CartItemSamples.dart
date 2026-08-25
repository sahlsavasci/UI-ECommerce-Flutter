import 'package:flutter/material.dart';

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // Melacak kuantitas untuk setiap item (berdasarkan indeks item dari 1 sampai 4)
  final Map<int, int> _quantities = {1: 1, 2: 1, 3: 1, 4: 1};

  // Melacak visibilitas untuk simulasi penghapusan item (dari 1 sampai 4)
  final Map<int, bool> _visibleItems = {1: true, 2: true, 3: true, 4: true};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 1; i <= 4; i++)
          // Bungkus kontainer produk dengan Visibility untuk simulasi penghapusan
          Visibility(
            visible: _visibleItems[i] ?? true,
            child: Container(
              height: 110,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Radio(
                    value: '',
                    groupValue: '',
                    activeColor: const Color(0xFF4C53A5),
                    onChanged: (index) {},
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    margin: const EdgeInsets.only(right: 15),
                    child: Image.asset('images/carts/$i.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Title',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                        Text(
                          '\$55',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol hapus item (Simulasi Deletion)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _visibleItems[i] = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Item $i disembunyikan dari keranjang'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                        Row(
                          children: [
                            // Tombol tambah item
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _quantities[i] = (_quantities[i] ?? 1) + 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.add, size: 18),
                              ),
                            ),

                            // Jumlah item dinamis dengan padding nol di depan
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                (_quantities[i] ?? 1).toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4C53A5),
                                ),
                              ),
                            ),

                            // Tombol kurang item
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if ((_quantities[i] ?? 1) > 1) {
                                    _quantities[i] = (_quantities[i] ?? 1) - 1;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.remove, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
