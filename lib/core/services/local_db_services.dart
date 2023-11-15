import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  final SharedPreferences prefs;

  LocalDBServices(this.prefs);

  Future<void> setMap(Map<String, dynamic> favorites, String key) async {
    try {
      await prefs.setString(key, json.encode(favorites));
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getMap(String key) async {
    try {
      final String? favoritesJson = prefs.getString(key);
      if (favoritesJson == null) {
        return {};
      }
      final Map<String, dynamic> favorites =
          Map<String, dynamic>.from(json.decode(favoritesJson));
      return favorites;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMap(String key) async {
    try {
      await prefs.remove(key);
    } catch (e) {
      rethrow;
    }

    // Future<void> clearAll() async {
    //   try {
    //     await prefs.clear();
    //   } catch (e) {
    //     rethrow;
    //   }
    // }
  }
}
