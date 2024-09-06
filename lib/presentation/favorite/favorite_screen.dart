import 'package:flutter/material.dart';
import '../../components/product_card.dart';
import '../../data/demo_data.dart';
import '../../helper/shared_preferences_product.dart'; // Ensure this is the correct file
import '../../models/Product.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Product>> _favoriteProductsFuture;

  Future<List<Product>> _loadFavoriteProducts() async {
    List<String> favoriteIds = await ProductPreferences.loadFavorites();

    // Fetch products from the repository or data source
    List<Product> favoriteProducts = [];
    for (String id in favoriteIds) {
      try {
        Product product = await _fetchProductById(id);
        favoriteProducts.add(product);
      } catch (e) {
        // Handle errors
      }
    }

    return favoriteProducts;
  }

  Future<Product> _fetchProductById(String id) async {
    // Replace with actual product fetching logic
    return demoProducts.firstWhere(
          (product) => product.id == id,
      orElse: () => throw Exception('Product not found'),
    );
  }

  @override
  void initState() {
    super.initState();
    _favoriteProductsFuture = _loadFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Product>>(
        future: _favoriteProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No favorites yet"));
          }

          final favoriteProducts = snapshot.data!;

          return Column(
            children: [
              Text(
                "Favorites",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: favoriteProducts.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => ProductCard(
                      product: favoriteProducts[index],
                      onPress: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                          product: favoriteProducts[index],
                          onUpdate: (updatedProduct) {
                            setState(() {
                              // Update the product and save the state
                              favoriteProducts[index] = updatedProduct;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
