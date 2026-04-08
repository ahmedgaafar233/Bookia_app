import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/wishlist/domain/repos/base_wishlist_repo.dart';

class GetWishlistUseCase {
  final BaseWishlistRepo repo;
  const GetWishlistUseCase(this.repo);

  Future<ProductResponseModel> call() => repo.getWishlist();
}

class AddToWishlistUseCase {
  final BaseWishlistRepo repo;
  const AddToWishlistUseCase(this.repo);

  Future<bool> call({required int productId}) =>
      repo.addToWishlist(productId: productId);
}

class RemoveFromWishlistUseCase {
  final BaseWishlistRepo repo;
  const RemoveFromWishlistUseCase(this.repo);

  Future<bool> call({required int productId}) =>
      repo.removeFromWishlist(productId: productId);
}
