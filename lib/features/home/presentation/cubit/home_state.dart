part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

// Sliders States
class GetSlidersLoading extends HomeState {}
class GetSlidersSuccess extends HomeState {}
class GetSlidersError extends HomeState {}

// Best Seller States
class GetBestSellerLoading extends HomeState {}
class GetBestSellerSuccess extends HomeState {}
class GetBestSellerError extends HomeState {}
