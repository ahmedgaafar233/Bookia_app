import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/home/data/datasources/home_remote_data_source.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/data/models/slider_response_model.dart';
import 'package:bookia/feature/home/domain/repos/base_home_repo.dart';

class HomeRepository implements BaseHomeRepo {
  final BaseHomeRemoteDataSource remoteDataSource;

  const HomeRepository(this.remoteDataSource);

  @override
  Future<SliderResponseModel> getSliders() async {
    try {
      return await remoteDataSource.getSliders();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<ProductResponseModel> getBestSeller() async {
    try {
      return await remoteDataSource.getBestSeller();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
