import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/data/models/slider_response_model.dart';
import 'package:dio/dio.dart';

abstract class BaseHomeRemoteDataSource {
  Future<SliderResponseModel> getSliders();
  Future<ProductResponseModel> getBestSeller();
}

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  final DioConsumer dioConsumer;
  const HomeRemoteDataSource(this.dioConsumer);

  @override
  Future<SliderResponseModel> getSliders() async {
    try {
      final response = await dioConsumer.get(ApiConstants.sliders);
      return SliderResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch sliders',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProductResponseModel> getBestSeller() async {
    try {
      final response = await dioConsumer.get(ApiConstants.bestSeller);
      return ProductResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch best sellers',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
