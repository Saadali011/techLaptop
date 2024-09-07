import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../data/product_repository.dart';

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
  int numOfItem;

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
    this.numOfItem = 1,
  }) : _isFavourite = isFavourite {
    _initialize();
  }

  Future<void> _initialize() async {
    _isFavourite = await _loadFavouriteStatus();
  }

  Future<bool> _loadFavouriteStatus() async {
    List<String> favoriteIds = await ProductPreferences.loadFavorites();
    return favoriteIds.contains(id);
  }

  bool get isFavourite => _isFavourite;

  Future<void> toggleFavourite() async {
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

  Product copyWith({bool? isFavourite}) {
    return Product(
      id: id,
      title: title,
      brandName: brandName,
      images: images,
      price: price,
      description: description,
      rating: rating,
      colors: colors,
      isFavourite: isFavourite ?? _isFavourite,
      isPopular: isPopular,
      numOfItem: numOfItem,
    );
  }

  static Product getProductById(String productId) {
    // Assuming `demoProducts` is a list of products from somewhere
    return demoProducts.firstWhere(
          (product) => product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'images': images,
    'rating': rating,
    'description': description,
    'numOfItem': numOfItem,
    'brandName': brandName,
    'colors': colors.map((color) => color.value).toList(),
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        images: List<String>.from(json['images']),
        rating: json['rating'],
        description: json['description'],
        numOfItem: json['numOfItem'],
        brandName: json['brandName'],
        colors: List<Color>.from(
          json['colors'].map(
                (color) => Color(int.parse(color.toString())),
          ),
        ),
      );
    } catch (e) {
      throw Exception('Error parsing Product from JSON: $e');
    }
  }
}
