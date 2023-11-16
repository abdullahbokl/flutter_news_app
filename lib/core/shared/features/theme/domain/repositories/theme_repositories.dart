import 'package:dartz/dartz.dart';

abstract class ThemeRepo {
  Future<Either<String, bool>> changeThemeMode();

  Future<Either<String, bool>> getThemeMode();
}
