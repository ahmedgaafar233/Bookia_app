import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/domain/repos/base_home_repo.dart';

class GetBestSellerUseCase {
  final BaseHomeRepo repo;
  const GetBestSellerUseCase(this.repo);

  Future<ProductResponseModel> call() => repo.getBestSeller();
}
