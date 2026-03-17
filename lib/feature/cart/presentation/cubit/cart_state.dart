part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class GetCartLoading extends CartState {}
class GetCartSuccess extends CartState {}
class GetCartError extends CartState {}

class AddToCartLoading extends CartState {}
class AddToCartSuccess extends CartState {}
class AddToCartError extends CartState {
  final String message;
  AddToCartError(this.message);
}

class RemoveFromCartLoading extends CartState {}
class RemoveFromCartSuccess extends CartState {}
class RemoveFromCartError extends CartState {}

class CheckoutLoadingState extends CartState {}
class CheckoutSuccessState extends CartState {}
class CheckoutErrorState extends CartState {}

class GetGovernoratesLoadingState extends CartState {}
class GetGovernoratesSuccessState extends CartState {}
class GetGovernoratesErrorState extends CartState {}

class PlaceOrderLoadingState extends CartState {}
class PlaceOrderSuccessState extends CartState {}
class PlaceOrderErrorState extends CartState {}
