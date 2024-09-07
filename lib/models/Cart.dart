// lib/models/cart.dart
import '../../../models/cart.dart';  // Ensure this import is correct

import 'Product.dart';

class Cart {
  final Product product;
  int numOfItem;

  Cart({required this.product, required this.numOfItem});
}
