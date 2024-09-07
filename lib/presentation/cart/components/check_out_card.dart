import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/demo_cart.dart';
import '../../../data/demo_data.dart';
import '../../../models/Cart.dart';
import '../../../models/Product.dart';
import '../../Notifications/notification.dart';

class CheckoutCard extends StatelessWidget {
  final double totalPrice;

  const CheckoutCard({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Total:\n ${totalPrice > 0 ? "\$$totalPrice" : ""}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      _showOrderConfirmationDialog(context);
                    },
                    child: const Text("Check Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order Confirmed"),
          content: const Text("Your order has been placed successfully."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _navigateToNotificationScreen(context);
                // Add order notification
                List<Product> addedProducts = [demoProducts[0]]; // Example product added to cart
                notifications.add("Your order has been placed: ${addedProducts.map((p) => p.title).join(', ')}");
                // Clear cart items
                demoCarts.clear();
                // Refresh the cart screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNotificationScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationScreen(
          notifications: notifications, // Show all notifications
          products: [demoProducts[0]], // Pass the product data (example)
        ),
      ),
    );
  }
}

// Example notifications list
List<String> notifications = [
  "You have a new message",
  "Your order has been shipped",
  // Add more notifications as needed
];
