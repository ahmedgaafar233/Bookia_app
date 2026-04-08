import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/data/models/slider_response_model.dart';

abstract class BaseHomeRepo {
  Future<SliderResponseModel> getSliders();
  Future<ProductResponseModel> getBestSeller();
}
