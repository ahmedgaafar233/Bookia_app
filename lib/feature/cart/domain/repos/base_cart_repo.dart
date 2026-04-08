import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';

abstract class BaseCartRepo {
  Future<CartResponseModel> getCart();
  Future<CartResponseModel> addToCart({required int productId});
  Future<CartResponseModel> updateCart({
    required int cartItemId,
    required int quantity,
  });
  Future<CartResponseModel> removeFromCart({required int cartItemId});
}
