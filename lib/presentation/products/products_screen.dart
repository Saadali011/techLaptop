import 'package:flutter/material.dart';
import '../../components/product_card.dart';
import '../../data/demo_data.dart';
import '../../models/Product.dart';
import '../details/details_screen.dart';
import '../home/components/home_header.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  static String routeName = "/products";

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _filteredProducts = demoProducts;
  String _searchQuery = '';

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = demoProducts.where((product) {
        final productTitle = product.title.toLowerCase();
        final productBrand = product.brandName.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return productTitle.contains(searchLowerCase) ||
            productBrand.contains(searchLowerCase);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Products", style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5),
            HomeHeader(onSearchChanged: _handleSearchChanged,focusNode: FocusNode(),),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: _filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: _filteredProducts[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments: ProductDetailsArguments(
                        product: _filteredProducts[index],
                        onUpdate: (updatedProduct) {
                          // Handle product update if necessary
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
