import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  String _selectedPayment = 'cod';
  bool _processing = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  List<dynamic> get _items {
    return context.read<CartProvider>().items.where((item) => item.isSelected).toList();
  }

  double get _subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get _shipping => _subtotal > 200 ? 0 : 15.0;
  double get _discount => _subtotal * 0.1;
  double get _total => _subtotal - _discount + _shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _processing
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSteps(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Ringkasan Pesanan'),
                  const SizedBox(height: 8),
                  ..._items.map((item) => _OrderItemTile(item: item)),
                  const Divider(height: 32),
                  _SummaryRow(label: 'Subtotal', value: '\$${_subtotal.toStringAsFixed(0)}'),
                  _SummaryRow(label: 'Diskon (10%)', value: '-\$${_discount.toStringAsFixed(0)}'),
                  _SummaryRow(label: 'Ongkos Kirim', value: _shipping == 0 ? 'GRATIS' : '\$${_shipping.toStringAsFixed(0)}'),
                  if (_subtotal < 200) const Padding(
                    padding: EdgeInsets.only(left: 120, bottom: 8),
                    child: Text('Gratis ongkir min. \$200', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                  ),
                  const Divider(height: 24),
                  _SummaryRow(label: 'Total', value: '\$${_total.toStringAsFixed(0)}', bold: true),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Alamat Pengiriman'),
                  const SizedBox(height: 8),
                  CustomTextField(controller: _nameCtrl, labelText: 'Nama Lengkap', prefixIcon: Icons.person_outline,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _phoneCtrl, labelText: 'Nomor HP', prefixIcon: Icons.phone_outlined, keyboardType: TextInputType.phone,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _addressCtrl, labelText: 'Alamat Lengkap', prefixIcon: Icons.location_on_outlined, maxLines: 3,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _cityCtrl, labelText: 'Kota', prefixIcon: Icons.map_outlined,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Metode Pembayaran'),
                  const SizedBox(height: 8),
                  _PaymentOption(value: 'cod', icon: Icons.money, title: 'Bayar di Tempat (COD)', desc: 'Bayar saat barang diterima', selected: _selectedPayment, onSelected: _setPayment),
                  _PaymentOption(value: 'transfer', icon: Icons.account_balance, title: 'Transfer Bank', desc: 'BCA, Mandiri, BNI', selected: _selectedPayment, onSelected: _setPayment),
                  _PaymentOption(value: 'ewallet', icon: Icons.wallet, title: 'E-Wallet', desc: 'GoPay, OVO, DANA', selected: _selectedPayment, onSelected: _setPayment),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Bayar \$${_total.toStringAsFixed(0)}', onPressed: _onPlaceOrder),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  void _setPayment(String method) { setState(() => _selectedPayment = method); }

  Widget _buildSteps() {
    return Row(children: [
      _StepChip(label: 'Keranjang', done: true),
      Expanded(child: Divider(color: AppTheme.border)),
      _StepChip(label: 'Pengiriman', active: true),
      Expanded(child: Divider(color: AppTheme.border)),
      _StepChip(label: 'Pembayaran', active: true),
    ]);
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary));
  }

  void _onPlaceOrder() {
    if (!_formKey.currentState!.validate()) return;
    final ctx = context;
    setState(() => _processing = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!ctx.mounted) return;
      setState(() => _processing = false);
      final order = Order(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        items: List.from(_items),
        subtotal: _subtotal,
        shippingCost: _shipping,
        discount: _discount,
        total: _total,
        customerName: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        paymentMethod: _selectedPayment,
        createdAt: DateTime.now(),
      );
      context.read<OrderProvider>().placeOrder(order);
      Navigator.pushReplacementNamed(ctx, 'OrderSuccess', arguments: order);
    });
  }
}

class _OrderItemTile extends StatelessWidget {
  final dynamic item;
  const _OrderItemTile({required this.item});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Container(
        width: 48, height: 48,
        decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.product.imagePath,
            width: 48, height: 48, fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported, size: 24, color: Colors.grey),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        Text('x${item.quantity}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ])),
      Text('\$${item.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary)),
    ]),
  );
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final bool bold;
  const _SummaryRow({required this.label, required this.value, this.bold = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Text(label, style: TextStyle(fontSize: 14, color: AppTheme.textSecondary, fontWeight: bold ? FontWeight.w600 : FontWeight.normal)),
      const Spacer(),
      Text(value, style: TextStyle(fontSize: 14, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: bold ? AppTheme.primary : AppTheme.textPrimary)),
    ]),
  );
}

class _PaymentOption extends StatelessWidget {
  final String value, title, desc;
  final IconData icon;
  final String selected;
  final ValueChanged<String> onSelected;
  const _PaymentOption({
    required this.value, required this.icon, required this.title, required this.desc,
    required this.selected, required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onSelected(value),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: isSelected ? AppTheme.primary : AppTheme.border),
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? AppTheme.primary.withValues(alpha: 0.05) : Colors.white,
            ),
            child: Row(children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: AppTheme.primary)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                Text(desc, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ])),
              Radio<String>(
                value: value,
                // ignore: deprecated_member_use
                groupValue: selected,
                onChanged: (v) => onSelected(v!),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  final String label;
  final bool active, done;
  const _StepChip({required this.label, this.active = false, this.done = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: done ? AppTheme.success : (active ? AppTheme.primary : AppTheme.border),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
  );
}
