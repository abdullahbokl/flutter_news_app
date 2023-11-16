import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/usecases/base_usecase.dart';
import '../repositories/news_repository.dart';

class ChangeFavoriteStateUseCase
    extends BaseUseCase<Map<String, bool>, ChangeFavoriteStateParams> {
  final NewsRepo newsRepo;

  ChangeFavoriteStateUseCase(this.newsRepo);

  @override
  Future<Either<String, Map<String, bool>>> call(
    ChangeFavoriteStateParams parameters,
  ) async {
    return await newsRepo.changeFavoriteState(url: parameters.url);
  }
}

class ChangeFavoriteStateParams extends Equatable {
  final String url;

  const ChangeFavoriteStateParams({
    required this.url,
  });

  @override
  List<Object?> get props => [url];
}
