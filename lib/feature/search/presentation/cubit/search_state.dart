import 'package:bookia/feature/home/data/models/product_response_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Product> products;
  SearchSuccess(this.products);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
