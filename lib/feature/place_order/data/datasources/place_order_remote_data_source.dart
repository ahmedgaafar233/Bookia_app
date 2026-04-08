import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/place_order/data/models/governorates_response.dart';
import 'package:dio/dio.dart';

abstract class BasePlaceOrderRemoteDataSource {
  Future<GovernoratesResponse> getGovernorates();
  Future<bool> placeOrder({
    required String name,
    required String email,
    required String address,
    required String phone,
    required int governorateId,
  });
}

class PlaceOrderRemoteDataSource implements BasePlaceOrderRemoteDataSource {
  final DioConsumer dioConsumer;
  const PlaceOrderRemoteDataSource(this.dioConsumer);

  @override
  Future<GovernoratesResponse> getGovernorates() async {
    try {
      final response = await dioConsumer.get(ApiConstants.governorates);
      return GovernoratesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch governorates',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> placeOrder({
    required String name,
    required String email,
    required String address,
    required String phone,
    required int governorateId,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.placeOrder,
        data: {
          'name': name,
          'email': email,
          'address': address,
          'phone': phone,
          'governorate_id': governorateId,
        },
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to place order',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
