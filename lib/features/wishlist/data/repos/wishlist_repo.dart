import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/features/home/data/models/product_response_model.dart';

class WishlistRepository {
  final DioConsumer dioConsumer;

  WishlistRepository(this.dioConsumer);

  Future<ProductResponseModel> getWishlist() async {
    final response = await dioConsumer.get(ApiConstants.wishlist);
    return ProductResponseModel.fromJson(response.data);
  }

  Future<bool> addToWishlist({required int productId}) async {
    final response = await dioConsumer.post(
      ApiConstants.addToWishlist,
      data: {'product_id': productId},
    );
    return response.statusCode == 200;
  }

  Future<bool> removeFromWishlist({required int productId}) async {
    final response = await dioConsumer.post(
      ApiConstants.removeFromWishlist,
      data: {'product_id': productId},
    );
    return response.statusCode == 200;
  }
}
