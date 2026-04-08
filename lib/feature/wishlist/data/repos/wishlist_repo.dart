import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:bookia/feature/wishlist/domain/repos/base_wishlist_repo.dart';

class WishlistRepository implements BaseWishlistRepo {
  final BaseWishlistRemoteDataSource remoteDataSource;

  const WishlistRepository(this.remoteDataSource);

  @override
  Future<ProductResponseModel> getWishlist() async {
    try {
      return await remoteDataSource.getWishlist();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> addToWishlist({required int productId}) async {
    try {
      return await remoteDataSource.addToWishlist(productId: productId);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> removeFromWishlist({required int productId}) async {
    try {
      return await remoteDataSource.removeFromWishlist(productId: productId);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
