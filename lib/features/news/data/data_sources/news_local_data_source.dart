import '../../../../core/services/local_db_services.dart';
import '../../../../core/utils/app_strings.dart';

abstract class NewsLocalDataSource {
  Future<Map<String, bool>> changeFavoriteState(String? url);

  Future<Map<String, bool>> getFavorites();

  Future<void> clearFavorites();
}

class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  final LocalDBServices localDBServices;

  NewsLocalDataSourceImpl(this.localDBServices);

  @override
  Future<Map<String, bool>> changeFavoriteState(String? url) async {
    try {
      final Map<String, bool> favorites = await getFavorites();
      if (url == null) return favorites;
      if (favorites.containsKey(url)) {
        favorites[url] = !favorites[url]!;
      } else {
        favorites[url] = true;
      }
      if (!favorites[url]!) favorites.remove(url);

      await localDBServices.setMap(AppStrings.favoritesKey, favorites);
      return favorites;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, bool>> getFavorites() async {
    try {
      final Map<String, dynamic> favorites =
          await localDBServices.getMap(AppStrings.favoritesKey);
      return Map<String, bool>.from(favorites);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearFavorites() {
    try {
      return localDBServices.deleteMap(AppStrings.favoritesKey);
    } catch (e) {
      rethrow;
    }
  }
}
