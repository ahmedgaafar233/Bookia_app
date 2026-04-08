import 'package:bookia/feature/home/data/models/product_response_model.dart';

abstract class BaseSearchRepo {
  Future<ProductResponseModel> searchProducts({required String name});
}
