import 'package:bookia/feature/wishlist/domain/repos/base_wishlist_repo.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_action_state.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  final BaseWishlistRepo repository;
  WishlistActionCubit(this.repository) : super(WishlistActionInitial());

  bool isProductInWishlist(int productId) {
    return SharedPrefs.isProductInWishlist(productId);
  }

  Future<void> toggleWishlist(int productId) async {
    emit(WishlistActionLoadingState());
    try {
      if (isProductInWishlist(productId)) {
        await repository.removeFromWishlist(productId: productId);
        emit(WishlistActionSuccessState('Removed from wishlist'));
      } else {
        await repository.addToWishlist(productId: productId);
        emit(WishlistActionSuccessState('Added to wishlist'));
      }
    } catch (e) {
      emit(WishlistActionErrorState(e.toString()));
    }
  }
}
