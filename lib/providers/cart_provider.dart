import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [
    CartItem(
      product: const Product(
        id: '1',
        title: 'Nike Air Max',
        description: 'Comfortable running shoes with premium cushioning',
        price: 55.0,
        discountPercent: 10,
        imagePath: 'images/carts/1.png',
        category: 'Outfit',
      ),
      quantity: 1,
    ),
    CartItem(
      product: const Product(
        id: '2',
        title: 'Sports Watch',
        description: 'Waterproof smart fitness tracker watch',
        price: 45.0,
        discountPercent: 5,
        imagePath: 'images/carts/2.png',
        category: 'Electronic',
      ),
      quantity: 1,
    ),
    CartItem(
      product: const Product(
        id: '3',
        title: 'Leather Backpack',
        description: 'Durable and spacious casual leather backpack',
        price: 70.0,
        discountPercent: 15,
        imagePath: 'images/carts/3.png',
        category: 'Outfit',
      ),
      quantity: 1,
    ),
    CartItem(
      product: const Product(
        id: '4',
        title: 'Wireless Headphones',
        description: 'Noise cancelling Bluetooth 5.0 headphones',
        price: 85.0,
        discountPercent: 20,
        imagePath: 'images/carts/4.png',
        category: 'Electronic',
      ),
      quantity: 1,
    ),
  ];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items
      .where((item) => item.isSelected)
      .fold(0.0, (sum, item) => sum + item.totalPrice);

  void addToCart(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void toggleSelection(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].isSelected = !_items[index].isSelected;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
