import 'package:dartz/dartz.dart';

import '../../data/data_sources/theme_local_data_source.dart';
import '../../domain/repositories/theme_repositories.dart';

class ThemeRepoImpl extends ThemeRepo {
  final ThemeLocalDataSource localDataSource;

  ThemeRepoImpl(this.localDataSource);

  @override
  Future<Either<String, bool>> changeThemeMode() async {
    try {
      final isDarkModeEnabled = await localDataSource.changeThemeMode();
      return Right(isDarkModeEnabled);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> getThemeMode() async {
    try {
      final isDarkModeEnabled = await localDataSource.getThemeMode();
      return Right(isDarkModeEnabled);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
