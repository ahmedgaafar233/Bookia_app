import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/wishlist/domain/repos/base_wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final BaseWishlistRepo wishlistRepository;
  WishlistCubit(this.wishlistRepository) : super(WishlistInitial());

  ProductResponseModel? wishlistModel;
  List<String> wishlistIds = [];

  Future<void> getWishlist() async {
    emit(GetWishlistLoading());
    try {
      wishlistModel = await wishlistRepository.getWishlist();
      if (wishlistModel?.status != null &&
          wishlistModel!.status! >= 200 &&
          wishlistModel!.status! < 300) {
        SharedPrefs.cacheWishlistIds(wishlistModel?.data?.products ?? []);
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
      final success =
          await wishlistRepository.addToWishlist(productId: productId);
      if (success) {
        emit(AddToWishlistSuccess());
        getWishlist(); // Refresh and re-cache
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
      final success =
          await wishlistRepository.removeFromWishlist(productId: productId);
      if (success) {
        emit(RemoveFromWishlistSuccess());
        getWishlist(); // Refresh and re-cache
      } else {
        emit(RemoveFromWishlistError());
      }
    } catch (e) {
      emit(RemoveFromWishlistError());
    }
  }
}
