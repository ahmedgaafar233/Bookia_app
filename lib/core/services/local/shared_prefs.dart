import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;

  static const String _wishlistKey = 'wishlistIds';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setWishlistIds(List<String> ids) async {
    await prefs.setStringList(_wishlistKey, ids);
  }

  static List<String> getWishlistIds() {
    return prefs.getStringList(_wishlistKey) ?? [];
  }
}
