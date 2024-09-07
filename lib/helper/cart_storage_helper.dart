// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/Cart.dart';
//
// class CartStorageHelper {
//   static const _cartKey = 'cart';
//
//   static Future<void> saveCart(List<Cart> cart) async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
//     await prefs.setString(_cartKey, cartJson);
//   }
//
//   static Future<List<Cart>> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = prefs.getString(_cartKey);
//     if (cartJson != null) {
//       final List<dynamic> decodedList = jsonDecode(cartJson);
//       return decodedList.map((json) => Cart.fromJson(json)).toList();
//     }
//     return [];
//   }
// }
