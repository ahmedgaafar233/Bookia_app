import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:bookia/feature/search/domain/repos/base_search_repo.dart';

class SearchRepository implements BaseSearchRepo {
  final BaseSearchRemoteDataSource remoteDataSource;

  const SearchRepository(this.remoteDataSource);

  @override
  Future<ProductResponseModel> searchProducts({required String name}) async {
    try {
      return await remoteDataSource.searchProducts(name: name);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
