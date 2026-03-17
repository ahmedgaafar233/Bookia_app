import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/place_order/data/models/governorates_response.dart';

class PlaceOrderRepository {
  final DioConsumer dioConsumer;

  PlaceOrderRepository(this.dioConsumer);

  Future<GovernoratesResponse> getGovernorates() async {
    final response = await dioConsumer.get(ApiConstants.governorates);
    return GovernoratesResponse.fromJson(response.data);
  }

  Future<bool> placeOrder({
    required String name,
    required String email,
    required String address,
    required String phone,
    required int governorateId,
  }) async {
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
  }
}
