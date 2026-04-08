import 'package:bookia/feature/home/data/models/slider_response_model.dart';
import 'package:bookia/feature/home/domain/repos/base_home_repo.dart';

class GetSlidersUseCase {
  final BaseHomeRepo repo;
  const GetSlidersUseCase(this.repo);

  Future<SliderResponseModel> call() => repo.getSliders();
}
