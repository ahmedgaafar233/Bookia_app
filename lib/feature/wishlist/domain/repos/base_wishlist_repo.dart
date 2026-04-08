import 'package:bookia/feature/home/data/models/product_response_model.dart';

abstract class BaseWishlistRepo {
  Future<ProductResponseModel> getWishlist();
  Future<bool> addToWishlist({required int productId});
  Future<bool> removeFromWishlist({required int productId});
}
