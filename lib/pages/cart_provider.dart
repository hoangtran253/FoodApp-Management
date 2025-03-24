import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    // Kiểm tra nếu sản phẩm đã có trong giỏ
    bool exists = false;
    for (var item in _cartItems) {
      if (item['name'] == product['name']) {
        item['quantity'] += product['quantity'] ?? 1;
        exists = true;
        break;
      }
    }

    if (!exists) {
      _cartItems.add({
        'name': product['name'],
        'price': product['price'],
        'image': product['image'],
        'quantity': product['quantity'] ?? 1,
      });
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }
}
