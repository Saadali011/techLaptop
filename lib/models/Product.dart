import 'package:flutter/material.dart';
import 'package:laptopharbor/data/demo_data.dart';
import '../helper/shared_preferences_product.dart';

class Product {
  final String id;
  final String title;
  final String brandName;
  final List<String> images;
  final double price;
  final String description;
  final double rating;
  final List<Color> colors;
  late bool _isFavourite;
  final bool isPopular;

  Product({
    required this.id,
    required this.title,
    required this.brandName,
    required this.images,
    required this.price,
    required this.description,
    required this.rating,
    required this.colors,
    bool isFavourite = false,
    this.isPopular = false,
  }) {
    _isFavourite = isFavourite;
    _loadFavouriteStatus();
  }

  // Load favourite status from SharedPreferences
  void _loadFavouriteStatus() async {
    List<String> favoriteIds = await ProductPreferences.loadFavorites();
    _isFavourite = favoriteIds.contains(id);
  }

  bool get isFavourite => _isFavourite;

  // Toggle Favorite
  void toggleFavourite() async {
    _isFavourite = !_isFavourite;
    await _updatePreferences();
  }

  Future<void> _updatePreferences() async {
    List<String> favoriteIds = await ProductPreferences.loadFavorites();

    if (_isFavourite && !favoriteIds.contains(id)) {
      favoriteIds.add(id);
    } else if (!_isFavourite && favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    }

    await ProductPreferences.saveFavorites(favoriteIds);
  }

  // Get a product by ID
  static Product getProductById(String productId) {
    return demoProducts.firstWhere(
          (product) => product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );
  }
}

