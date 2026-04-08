import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:dio/dio.dart';

abstract class BaseWishlistRemoteDataSource {
  Future<ProductResponseModel> getWishlist();
  Future<bool> addToWishlist({required int productId});
  Future<bool> removeFromWishlist({required int productId});
}

class WishlistRemoteDataSource implements BaseWishlistRemoteDataSource {
  final DioConsumer dioConsumer;
  const WishlistRemoteDataSource(this.dioConsumer);

  @override
  Future<ProductResponseModel> getWishlist() async {
    try {
      final response = await dioConsumer.get(ApiConstants.wishlist);
      return ProductResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch wishlist',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> addToWishlist({required int productId}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.addToWishlist,
        data: {'product_id': productId},
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to add to wishlist',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> removeFromWishlist({required int productId}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.removeFromWishlist,
        data: {'product_id': productId},
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to remove from wishlist',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
