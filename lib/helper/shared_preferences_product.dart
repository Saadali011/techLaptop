import 'package:shared_preferences/shared_preferences.dart';

class ProductPreferences {
  static const String favoritesKey = 'favorites';
  static const String popularKey = 'popular_products';

  // Save the list of favorite product IDs
  static Future<void> saveFavorites(List<String> productIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoritesKey, productIds);
  }

  // Load the list of favorite product IDs
  static Future<List<String>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey) ?? [];
  }

  // Save the list of popular product IDs
  static Future<void> savePopularProducts(List<String> productIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(popularKey, productIds);
  }

  // Load the list of popular product IDs
  static Future<List<String>> loadPopularProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(popularKey) ?? [];
  }
}
