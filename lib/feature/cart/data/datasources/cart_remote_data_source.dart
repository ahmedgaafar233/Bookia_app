import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:dio/dio.dart';

abstract class BaseCartRemoteDataSource {
  Future<CartResponseModel> getCart();
  Future<CartResponseModel> addToCart({required int productId});
  Future<CartResponseModel> updateCart({
    required int cartItemId,
    required int quantity,
  });
  Future<CartResponseModel> removeFromCart({required int cartItemId});
}

class CartRemoteDataSource implements BaseCartRemoteDataSource {
  final DioConsumer dioConsumer;
  const CartRemoteDataSource(this.dioConsumer);

  @override
  Future<CartResponseModel> getCart() async {
    try {
      final response = await dioConsumer.get(ApiConstants.cart);
      return CartResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch cart',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<CartResponseModel> addToCart({required int productId}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.addToCart,
        data: {'product_id': productId},
      );
      return CartResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to add to cart',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<CartResponseModel> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.updateCart,
        data: {'cart_item_id': cartItemId, 'quantity': quantity},
      );
      return CartResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to update cart',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<CartResponseModel> removeFromCart({required int cartItemId}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.removeFromCart,
        data: {'cart_item_id': cartItemId},
      );
      return CartResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to remove from cart',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
