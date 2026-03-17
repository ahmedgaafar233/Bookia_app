abstract class CartActionState {}

class CartActionInitial extends CartActionState {}

class CartActionLoadingState extends CartActionState {}

class CartActionSuccessState extends CartActionState {
  final String msg;
  CartActionSuccessState(this.msg);
}

class CartActionErrorState extends CartActionState {
  final String msg;
  CartActionErrorState(this.msg);
}
