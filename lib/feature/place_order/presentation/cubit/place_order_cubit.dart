import 'package:bookia/feature/place_order/data/models/governorate.dart';
import 'package:bookia/feature/place_order/domain/repos/base_place_order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final BasePlaceOrderRepo repository;
  PlaceOrderCubit(this.repository) : super(PlaceOrderInitial());

  List<GovernorateData> governorates = [];

  Future<void> getGovernorates() async {
    emit(GetGovernoratesLoadingState());
    try {
      final response = await repository.getGovernorates();
      governorates = response.data ?? [];
      emit(GetGovernoratesSuccessState());
    } catch (e) {
      emit(GetGovernoratesErrorState());
    }
  }

  Future<void> placeOrder({
    required String name,
    required String email,
    required String address,
    required String phone,
    required int governorateId,
  }) async {
    emit(PlaceOrderLoadingState());
    try {
      final success = await repository.placeOrder(
        name: name,
        email: email,
        address: address,
        phone: phone,
        governorateId: governorateId,
      );
      if (success) {
        emit(PlaceOrderSuccessState());
      } else {
        emit(PlaceOrderErrorState());
      }
    } catch (e) {
      emit(PlaceOrderErrorState());
    }
  }
}
