import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:bookia/features/wishlist/data/repos/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository wishlistRepository;
  WishlistCubit(this.wishlistRepository) : super(WishlistInitial());

  ProductResponseModel? wishlistModel;

  Future<void> getWishlist() async {
    emit(GetWishlistLoading());
    try {
      wishlistModel = await wishlistRepository.getWishlist();
      if (wishlistModel?.status == 200) {
        emit(GetWishlistSuccess());
      } else {
        emit(GetWishlistError());
      }
    } catch (e) {
      emit(GetWishlistError());
    }
  }

  Future<void> addToWishlist({required int productId}) async {
    emit(AddToWishlistLoading());
    try {
      final success = await wishlistRepository.addToWishlist(productId: productId);
      if (success) {
        emit(AddToWishlistSuccess());
        getWishlist(); // Refresh wishlist
      } else {
        emit(AddToWishlistError());
      }
    } catch (e) {
      emit(AddToWishlistError());
    }
  }

  Future<void> removeFromWishlist({required int productId}) async {
    emit(RemoveFromWishlistLoading());
    try {
      final success = await wishlistRepository.removeFromWishlist(productId: productId);
      if (success) {
        emit(RemoveFromWishlistSuccess());
        getWishlist(); // Refresh wishlist
      } else {
        emit(RemoveFromWishlistError());
      }
    } catch (e) {
      emit(RemoveFromWishlistError());
    }
  }
}
