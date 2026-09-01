import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double shippingCost;
  final double discount;
  final double total;
  final String customerName;
  final String phone;
  final String address;
  final String city;
  final String paymentMethod;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.discount,
    required this.total,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.city,
    required this.paymentMethod,
    required this.createdAt,
  });
}
