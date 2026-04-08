import 'package:bookia/feature/cart/domain/repos/base_cart_repo.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_action_state.dart';

class CartActionCubit extends Cubit<CartActionState> {
  final BaseCartRepo repository;
  CartActionCubit(this.repository) : super(CartActionInitial());

  bool isProductInCart(int productId) {
    return SharedPrefs.isProductInCart(productId);
  }

  Future<void> addToCart(int productId) async {
    emit(CartActionLoadingState());
    try {
      final response = await repository.addToCart(productId: productId);
      if (response.status != null &&
          response.status! >= 200 &&
          response.status! < 300) {
        emit(CartActionSuccessState('Added to cart successfully'));
      } else {
        emit(CartActionErrorState(response.message ?? 'Failed to add to cart'));
      }
    } catch (e) {
      emit(CartActionErrorState(e.toString()));
    }
  }
}
