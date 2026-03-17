abstract class WishlistActionState {}

class WishlistActionInitial extends WishlistActionState {}

class WishlistActionLoadingState extends WishlistActionState {}

class WishlistActionSuccessState extends WishlistActionState {
  final String msg;
  WishlistActionSuccessState(this.msg);
}

class WishlistActionErrorState extends WishlistActionState {
  final String msg;
  WishlistActionErrorState(this.msg);
}
