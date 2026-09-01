import 'package:flutter/foundation.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<Order> _orderHistory = [];
  Order? _currentOrder;

  List<Order> get orderHistory => List.unmodifiable(_orderHistory);
  Order? get currentOrder => _currentOrder;
  bool get hasOrder => _currentOrder != null;
  int get totalOrders => _orderHistory.length;

  void placeOrder(Order order) {
    _orderHistory.add(order);
    _currentOrder = order;
    notifyListeners();
  }

  void clearCurrentOrder() {
    _currentOrder = null;
    notifyListeners();
  }

  Order? getOrderById(String id) {
    try {
      return _orderHistory.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }
}
