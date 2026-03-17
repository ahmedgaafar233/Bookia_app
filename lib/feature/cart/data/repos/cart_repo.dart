import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/data/models/governorates_response/governorates_response.dart';

class CartRepository {
  final DioConsumer dioConsumer;

  CartRepository(this.dioConsumer);

  Future<CartResponseModel> getCart() async {
    final response = await dioConsumer.get(ApiConstants.cart);
    return CartResponseModel.fromJson(response.data);
  }

  Future<CartResponseModel> addToCart({required int productId}) async {
    final response = await dioConsumer.post(
      ApiConstants.addToCart,
      data: {'product_id': productId},
    );
    return CartResponseModel.fromJson(response.data);
  }

  Future<CartResponseModel> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.updateCart,
      data: {
        'cart_item_id': cartItemId,
        'quantity': quantity,
      },
    );
    return CartResponseModel.fromJson(response.data);
  }

  Future<CartResponseModel> removeFromCart({required int cartItemId}) async {
    final response = await dioConsumer.post(
      ApiConstants.removeFromCart,
      data: {'cart_item_id': cartItemId},
    );
    return CartResponseModel.fromJson(response.data);
  }
}
