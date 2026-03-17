import 'package:bookia/feature/wishlist/data/repos/wishlist_repo.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_action_state.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  final WishlistRepository repository;
  WishlistActionCubit(this.repository) : super(WishlistActionInitial());

  bool isProductInWishlist(int productId) {
    return SharedPrefs.isProductInWishlist(productId);
  }

  Future<void> toggleWishlist(int productId) async {
    emit(WishlistActionLoadingState());
    try {
      if (isProductInWishlist(productId)) {
        final response = await repository.removeFromWishlist(productId: productId);
        if (response.status != null && response.status! >= 200 && response.status! < 300) {
          emit(WishlistActionSuccessState('Removed from wishlist'));
        } else {
          emit(WishlistActionErrorState('Failed to remove from wishlist'));
        }
      } else {
        final response = await repository.addToWishlist(productId: productId);
        if (response.status != null && response.status! >= 200 && response.status! < 300) {
          emit(WishlistActionSuccessState('Added to wishlist'));
        } else {
          emit(WishlistActionErrorState('Failed to add to wishlist'));
        }
      }
    } catch (e) {
      emit(WishlistActionErrorState(e.toString()));
    }
  }
}
