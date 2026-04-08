import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/search/domain/repos/base_search_repo.dart';

class SearchUseCase {
  final BaseSearchRepo repo;
  const SearchUseCase(this.repo);

  Future<ProductResponseModel> call({required String name}) =>
      repo.searchProducts(name: name);
}
