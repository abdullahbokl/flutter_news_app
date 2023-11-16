import 'package:dartz/dartz.dart';

import '../../../../usecases/base_usecase.dart';
import '../repositories/theme_repositories.dart';

class GetThemeModeUseCase extends BaseUseCase<bool, NoParams> {
  final ThemeRepo themeRepository;

  GetThemeModeUseCase(this.themeRepository);

  @override
  Future<Either<String, bool>> call([NoParams? parameters]) async {
    return await themeRepository.getThemeMode();
  }
}
