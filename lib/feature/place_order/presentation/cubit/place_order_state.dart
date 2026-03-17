abstract class PlaceOrderState {}

class PlaceOrderInitial extends PlaceOrderState {}

class GetGovernoratesLoadingState extends PlaceOrderState {}
class GetGovernoratesSuccessState extends PlaceOrderState {}
class GetGovernoratesErrorState extends PlaceOrderState {}

class PlaceOrderLoadingState extends PlaceOrderState {}
class PlaceOrderSuccessState extends PlaceOrderState {}
class PlaceOrderErrorState extends PlaceOrderState {}
