import 'package:flutter/material.dart';
import '../../models/Product.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notifications";

  final List<String>? notifications;
  final List<Product>? products;

  const NotificationScreen({
    Key? key,
    this.notifications,
    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: notifications == null || notifications!.isEmpty
          ? Center(child: Text("No notifications available"))
          : ListView.builder(
        itemCount: notifications!.length,
        itemBuilder: (context, index) {
          final notification = notifications![index];
          final product = products != null && index < products!.length
              ? products![index]
              : null;

          return ListTile(
            leading: product != null
                ? Image.asset(
              product.images.isNotEmpty
                  ? product.images.first
                  : 'assets/images/placeholder.png', // Fallback image
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : null,
            title: Text(product?.title ?? "Product"),
            subtitle: Text(notification),
          );
        },
      ),
    );
  }
}
