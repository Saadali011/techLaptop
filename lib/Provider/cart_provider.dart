import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _carts = [];

  List<Cart> get carts => _carts;

  void addToCart(Cart cart) {
    _carts.add(cart);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _carts.removeAt(index);
    notifyListeners();
  }
}
