import 'package:shared_preferences/shared_preferences.dart';

class ProductPreferences {
  static const _favoriteKey = 'favorite_products';

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }

  static Future<void> saveFavorites(List<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_favoriteKey, favoriteIds);
  }
}
