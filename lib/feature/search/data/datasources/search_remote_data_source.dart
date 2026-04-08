import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:dio/dio.dart';

abstract class BaseSearchRemoteDataSource {
  Future<ProductResponseModel> searchProducts({required String name});
}

class SearchRemoteDataSource implements BaseSearchRemoteDataSource {
  final DioConsumer dioConsumer;
  const SearchRemoteDataSource(this.dioConsumer);

  @override
  Future<ProductResponseModel> searchProducts({required String name}) async {
    try {
      final response = await dioConsumer.get(
        ApiConstants.searchProduct,
        queryParameters: {'name': name},
      );
      return ProductResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Search failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
