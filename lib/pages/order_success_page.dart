import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as Order?;
    if (order == null) {
      return const Scaffold(body: Center(child: Text('Order tidak ditemukan')));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().clearCart();
      context.read<OrderProvider>().clearCurrentOrder();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(color: AppTheme.success.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, size: 56, color: AppTheme.success),
              ),
              const SizedBox(height: 24),
              const Text('Pesanan Berhasil!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 8),
              Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    _DetailRow(label: 'Total Dibayar', value: '\$${order.total.toStringAsFixed(0)}', bold: true),
                    _DetailRow(label: 'Metode Bayar', value: _paymentLabel(order.paymentMethod)),
                    _DetailRow(label: 'Alamat', value: '${order.address}, ${order.city}'),
                    _DetailRow(label: 'Tanggal', value: '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, 'HomePage', (_) => false),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Kembali Belanja', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _paymentLabel(String method) {
    switch (method) {
      case 'cod': return 'Bayar di Tempat';
      case 'transfer': return 'Transfer Bank';
      case 'ewallet': return 'E-Wallet';
      default: return method;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _DetailRow({required this.label, required this.value, this.bold = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: bold ? FontWeight.w600 : FontWeight.normal)),
      Text(value, style: TextStyle(fontSize: 13, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: AppTheme.textPrimary)),
    ]),
  );
}
