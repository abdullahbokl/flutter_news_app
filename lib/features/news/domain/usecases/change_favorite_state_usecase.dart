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
    return await newsRepo.changeFavoriteState(id: parameters.id);
  }
}

class ChangeFavoriteStateParams extends Equatable {
  final String id;

  const ChangeFavoriteStateParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
