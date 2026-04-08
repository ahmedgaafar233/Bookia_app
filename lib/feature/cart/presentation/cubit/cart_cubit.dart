import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/feature/cart/domain/repos/base_cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepo cartRepository;
  CartCubit(this.cartRepository) : super(CartInitial());

  CartResponseModel? cartModel;
  List<CartItem> products = [];
  String total = '';

  Future<void> getCart() async {
    emit(GetCartLoading());
    try {
      final response = await cartRepository.getCart();
      cartModel = response;
      if (response.status != null &&
          response.status! >= 200 &&
          response.status! < 300) {
        products = response.data?.cartItems ?? [];
        total = response.data?.total?.toString() ?? '0';
        SharedPrefs.cacheCartIds(products);
        emit(GetCartSuccess());
      } else {
        emit(GetCartError());
      }
    } catch (e) {
      emit(GetCartError());
    }
  }

  Future<void> addToCart({required int productId}) async {
    emit(AddToCartLoading());
    try {
      final response = await cartRepository.addToCart(productId: productId);
      if (response.status != null &&
          response.status! >= 200 &&
          response.status! < 300) {
        emit(AddToCartSuccess());
        getCart(); // Refresh cart after adding
      } else {
        emit(AddToCartError(response.message ?? 'Failed to add to cart'));
      }
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  Future<void> updateCart({required int cartItemId, required int quantity}) async {
    // Note: We don't necessarily need a loading state for every small update 
    // but for simplicity and clarity in UI we can use one or handle it locally.
    try {
      final response = await cartRepository.updateCart(
          cartItemId: cartItemId, quantity: quantity);
      if (response.status != null &&
          response.status! >= 200 &&
          response.status! < 300) {
        getCart(); // Refresh cart to get new totals and items
      }
    } catch (e) {
      emit(GetCartError());
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    emit(RemoveFromCartLoading());
    try {
      final response = await cartRepository.removeFromCart(cartItemId: cartItemId);
      if (response.status != null &&
          response.status! >= 200 &&
          response.status! < 300) {
        emit(RemoveFromCartSuccess());
        getCart(); // Refresh cart after removing
      } else {
        emit(RemoveFromCartError());
      }
    } catch (e) {
      emit(RemoveFromCartError());
    }
  }

  Future<void> checkout() async {
    emit(CheckoutLoadingState());
    // In a real app, maybe check for stock or something here
    await Future.delayed(const Duration(seconds: 1));
    emit(CheckoutSuccessState());
  }
}
