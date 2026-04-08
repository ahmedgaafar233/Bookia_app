import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/place_order/data/datasources/place_order_remote_data_source.dart';
import 'package:bookia/feature/place_order/data/models/governorates_response.dart';
import 'package:bookia/feature/place_order/domain/repos/base_place_order_repo.dart';

class PlaceOrderRepository implements BasePlaceOrderRepo {
  final BasePlaceOrderRemoteDataSource remoteDataSource;

  const PlaceOrderRepository(this.remoteDataSource);

  @override
  Future<GovernoratesResponse> getGovernorates() async {
    try {
      return await remoteDataSource.getGovernorates();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
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
      return await remoteDataSource.placeOrder(
        name: name,
        email: email,
        address: address,
        phone: phone,
        governorateId: governorateId,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
