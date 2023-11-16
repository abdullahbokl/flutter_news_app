import '../../../../../services/local_db_services.dart';
import '../../../../../utils/app_strings.dart';

abstract class ThemeLocalDataSource {
  Future<bool> changeThemeMode();

  Future<bool> getThemeMode();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  final LocalDBServices localDBServices;

  ThemeLocalDataSourceImpl(this.localDBServices);

  @override
  Future<bool> changeThemeMode() async {
    try {
      final bool isDarkModeEnabled = await getThemeMode();
      await localDBServices.set(AppStrings.themeModeKey, !isDarkModeEnabled);
      return !isDarkModeEnabled;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> getThemeMode() async {
    try {
      final isDarkModeEnabled =
          await localDBServices.get(AppStrings.themeModeKey);
      return isDarkModeEnabled ?? false;
    } catch (e) {
      rethrow;
    }
  }
}
