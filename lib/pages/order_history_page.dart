import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orderHistory;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: orders.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) => _OrderCard(order: orders[orders.length - 1 - index]),
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.receipt_long, size: 80, color: Colors.grey.shade300),
      const SizedBox(height: 16),
      const Text('Belum ada pesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
      const SizedBox(height: 8),
      Text('Pesanan kamu akan muncul di sini', style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
        child: const Text('Mulai Belanja', style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    ]),
  );
}

class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  String _statusText() {
    final now = DateTime.now();
    final diff = now.difference(order.createdAt).inDays;
    if (diff <= 1) return 'Diproses';
    if (diff <= 3) return 'Dikirim';
    return 'Selesai';
  }

  Color _statusColor() {
    switch (_statusText()) {
      case 'Diproses': return AppTheme.warning;
      case 'Dikirim': return AppTheme.secondary;
      default: return AppTheme.success;
    }
  }

  IconData _statusIcon() {
    switch (_statusText()) {
      case 'Diproses': return Icons.pending;
      case 'Dikirim': return Icons.local_shipping;
      default: return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _OrderDetailPage(order: order))),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: _statusColor().withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(_statusIcon(), size: 14, color: _statusColor()),
                const SizedBox(width: 4),
                Text(_statusText(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _statusColor())),
              ]),
            ),
            const Spacer(),
            Text('${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          ]),
          const SizedBox(height: 12),
          Text(order.id, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text('${order.items.length} item', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          const SizedBox(height: 12),
          Divider(color: AppTheme.border),
          const SizedBox(height: 8),
          Row(children: [
            const Text('Total', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const Spacer(),
            Text('\$${order.total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primary)),
          ]),
        ]),
      ),
    );
  }
}

class _OrderDetailPage extends StatelessWidget {
  final Order order;
  const _OrderDetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Pesanan', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
            ]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                  child: Text(_getStatusLabel(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.success)),
                ),
                const Spacer(),
                Text('${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ]),
              const SizedBox(height: 12),
              Text(order.id, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
              const Text('EcoGlobal E-Commerce', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ]),
          ),
          const SizedBox(height: 16),
          const Text('Item Pesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          ...order.items.map((item) => _DetailItemTile(item: item)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Ringkasan Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              _DetailRow(label: 'Subtotal', value: '\$${order.subtotal.toStringAsFixed(0)}'),
              _DetailRow(label: 'Diskon', value: '-\$${order.discount.toStringAsFixed(0)}'),
              _DetailRow(label: 'Ongkos Kirim', value: order.shippingCost == 0 ? 'GRATIS' : '\$${order.shippingCost.toStringAsFixed(0)}'),
              const Divider(height: 20),
              _DetailRow(label: 'Total', value: '\$${order.total.toStringAsFixed(0)}', bold: true),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Alamat Pengiriman', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 10),
              Text(order.customerName, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary)),
              Text(order.phone, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              const SizedBox(height: 4),
              Text('${order.address}, ${order.city}', style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              const SizedBox(height: 10),
              Text('Pembayaran: ${_paymentLabel(order.paymentMethod)}', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            ]),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Kembali', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }

  String _getStatusLabel() {
    final now = DateTime.now();
    final diff = now.difference(order.createdAt).inDays;
    if (diff <= 1) return 'Diproses';
    if (diff <= 3) return 'Dikirim';
    return 'Selesai';
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

class _DetailItemTile extends StatelessWidget {
  final dynamic item;
  const _DetailItemTile({required this.item});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(item.product.imagePath, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported, size: 28, color: Colors.grey)))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.product.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
        Text('x${item.quantity}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ])),
      Text('\$${item.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary)),
    ]),
  );
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _DetailRow({required this.label, required this.value, this.bold = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Text(label, style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: bold ? FontWeight.w600 : FontWeight.normal)),
      const Spacer(),
      Text(value, style: TextStyle(fontSize: 13, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: bold ? AppTheme.primary : AppTheme.textPrimary)),
    ]),
  );
}
