import 'package:shared_preferences/shared_preferences.dart';

class ProductPreferences {
  static const String _favoritesKey = 'favorites';
  static const String _popularKey = 'popular_products';

  // Save the list of favorite product IDs
  static Future<void> saveFavorites(List<String> productIds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, productIds);
  }

  // Load the list of favorite product IDs
  static Future<List<String>> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // Save the list of popular product IDs
  static Future<void> savePopularProducts(List<String> productIds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_popularKey, productIds);
  }

  // Load the list of popular product IDs
  static Future<List<String>> loadPopularProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_popularKey) ?? [];
  }
}
