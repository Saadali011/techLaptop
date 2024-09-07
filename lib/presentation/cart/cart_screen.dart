import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../Provider/cart_provider.dart';
import '../../models/cart.dart';  // Corrected import
import '../../data/demo_cart.dart'; // Ensure this file exists and is correctly imported
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart (${cartProvider.carts.length} items)"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: cartProvider.carts.isEmpty
            ? Center(child: Text("No items in cart"))
            : ListView.builder(
          itemCount: cartProvider.carts.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cartProvider.carts[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                cartProvider.removeFromCart(index);
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: cartProvider.carts[index]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(totalPrice: _calculateTotalPrice(cartProvider)),
    );
  }

  double _calculateTotalPrice(CartProvider cartProvider) {
    return cartProvider.carts.fold(
      0.0,
          (total, cart) => total + (cart.product.price * cart.numOfItem),
    );
  }
}
