import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/domain/repos/base_cart_repo.dart';

class GetCartUseCase {
  final BaseCartRepo repo;
  const GetCartUseCase(this.repo);

  Future<CartResponseModel> call() => repo.getCart();
}

class AddToCartUseCase {
  final BaseCartRepo repo;
  const AddToCartUseCase(this.repo);

  Future<CartResponseModel> call({required int productId}) =>
      repo.addToCart(productId: productId);
}

class UpdateCartUseCase {
  final BaseCartRepo repo;
  const UpdateCartUseCase(this.repo);

  Future<CartResponseModel> call({
    required int cartItemId,
    required int quantity,
  }) =>
      repo.updateCart(cartItemId: cartItemId, quantity: quantity);
}

class RemoveFromCartUseCase {
  final BaseCartRepo repo;
  const RemoveFromCartUseCase(this.repo);

  Future<CartResponseModel> call({required int cartItemId}) =>
      repo.removeFromCart(cartItemId: cartItemId);
}
