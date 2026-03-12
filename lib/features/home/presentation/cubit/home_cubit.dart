import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:bookia/features/home/data/models/slider_response_model.dart';
import 'package:bookia/features/home/data/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  SliderResponseModel? sliderResponseModel;
  ProductResponseModel? productResponseModel;

  Future<void> getSliders() async {
    emit(GetSlidersLoading());
    try {
      sliderResponseModel = await homeRepository.getSliders();
      if (sliderResponseModel?.status == 200) {
        emit(GetSlidersSuccess());
      } else {
        emit(GetSlidersError());
      }
    } catch (e) {
      emit(GetSlidersError());
    }
  }

  Future<void> getBestSeller() async {
    emit(GetBestSellerLoading());
    try {
      productResponseModel = await homeRepository.getBestSeller();
      if (productResponseModel?.status == 200) {
        emit(GetBestSellerSuccess());
      } else {
        emit(GetBestSellerError());
      }
    } catch (e) {
      emit(GetBestSellerError());
    }
  }
}
