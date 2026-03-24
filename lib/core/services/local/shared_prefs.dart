import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;

  static const String kWishlist = 'wishlistIds';
  static const String kCart = 'cartIds';
  static const String kToken = 'token';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Generic cache method as seen in screenshots
  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return prefs.get(key);
  }

  static Future<void> removeData(String key) async {
    await prefs.remove(key);
  }

  static void cacheWishlistIds(List<Product> items) {
    var ids = items.map((item) => item.id.toString()).toList();
    // Use the generic cache method
    cacheData(kWishlist, ids);
  }

  static List<int> getWishlistIds() {
    var ids = getData(kWishlist);
    if (ids is List<String>) {
      return ids.map((id) => int.tryParse(id) ?? 0).toList();
    } else {
      return [];
    }
  }

  static void cacheCartIds(List<CartItem> items) {
    var ids = items.map((item) => item.itemProductId?.toString() ?? '').toList();
    cacheData(kCart, ids);
  }

  static List<int> getCartIds() {
    var ids = getData(kCart);
    if (ids is List<String>) {
      return ids.map((id) => int.tryParse(id) ?? 0).toList();
    } else {
      return [];
    }
  }

  static bool isProductInWishlist(int productId) {
    return getWishlistIds().contains(productId);
  }

  static bool isProductInCart(int productId) {
    return getCartIds().contains(productId);
  }

  static void clear() {
    prefs.clear();
  }
}
