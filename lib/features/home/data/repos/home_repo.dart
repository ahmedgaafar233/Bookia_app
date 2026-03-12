import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:bookia/features/home/data/models/slider_response_model.dart';

class HomeRepository {
  final DioConsumer dioConsumer;

  HomeRepository(this.dioConsumer);

  Future<SliderResponseModel> getSliders() async {
    final response = await dioConsumer.get(ApiConstants.sliders);
    return SliderResponseModel.fromJson(response.data);
  }

  Future<ProductResponseModel> getBestSeller() async {
    final response = await dioConsumer.get(ApiConstants.bestSeller);
    return ProductResponseModel.fromJson(response.data);
  }
}
