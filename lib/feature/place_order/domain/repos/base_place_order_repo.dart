import 'package:bookia/feature/place_order/data/models/governorates_response.dart';

abstract class BasePlaceOrderRepo {
  Future<GovernoratesResponse> getGovernorates();
  Future<bool> placeOrder({
    required String name,
    required String email,
    required String address,
    required String phone,
    required int governorateId,
  });
}
