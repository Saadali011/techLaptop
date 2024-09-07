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

    // Use Future.wait to fetch all products concurrently
    List<Future<Product>> productFutures = favoriteIds.map((id) async {
      try {
        return Product.getProductById(id);
      } catch (e) {
        print("Error fetching product with ID $id: $e");
        // Return a default product instead of null
        return Product(
          id: id,
          title: 'Unknown',
          brandName: 'Unknown',
          images: [],
          price: 0.0,
          description: 'No description',
          rating: 0.0,
          colors: [Colors.grey],
        );
      }
    }).toList();

    // Wait for all futures to complete
    List<Product> favoriteProducts = await Future.wait(productFutures);

    return favoriteProducts;
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
