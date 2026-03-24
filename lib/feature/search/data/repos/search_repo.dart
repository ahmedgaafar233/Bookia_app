import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';

class SearchRepository {
  final DioConsumer dioConsumer;

  SearchRepository(this.dioConsumer);

  Future<ProductResponseModel> searchProducts({required String name}) async {
    final response = await dioConsumer.get(
      ApiConstants.searchProduct,
      queryParameters: {'name': name},
    );
    return ProductResponseModel.fromJson(response.data);
  }
}
