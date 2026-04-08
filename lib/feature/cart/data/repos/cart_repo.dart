import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/cart/data/datasources/cart_remote_data_source.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/domain/repos/base_cart_repo.dart';

class CartRepository implements BaseCartRepo {
  final BaseCartRemoteDataSource remoteDataSource;

  const CartRepository(this.remoteDataSource);

  @override
  Future<CartResponseModel> getCart() async {
    try {
      return await remoteDataSource.getCart();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<CartResponseModel> addToCart({required int productId}) async {
    try {
      return await remoteDataSource.addToCart(productId: productId);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<CartResponseModel> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      return await remoteDataSource.updateCart(
        cartItemId: cartItemId,
        quantity: quantity,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<CartResponseModel> removeFromCart({required int cartItemId}) async {
    try {
      return await remoteDataSource.removeFromCart(cartItemId: cartItemId);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
