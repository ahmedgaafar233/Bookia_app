import 'package:bookia/feature/search/data/repos/search_repo.dart';
import 'package:bookia/feature/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  Future<void> search(String name) async {
    if (name.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final response = await _searchRepository.searchProducts(name: name);
      if (response.status == 200) {
        emit(SearchSuccess(response.data?.products ?? []));
      } else {
        emit(SearchError(response.message ?? 'Search failed'));
      }
    } catch (e) {
      emit(SearchError('An error occurred during search'));
    }
  }
}
