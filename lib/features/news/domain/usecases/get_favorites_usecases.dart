import 'package:dartz/dartz.dart';

import '../../../../core/shared/usecases/base_usecase.dart';
import '../repositories/news_repository.dart';

class GetFavoritesUseCase extends BaseUseCase<Map<String, bool>, NoParams> {
  final NewsRepo newsRepo;

  GetFavoritesUseCase(this.newsRepo);

  @override
  Future<Either<String, Map<String, bool>>> call([NoParams? parameters]) async {
    return await newsRepo.getFavorites();
  }
}
