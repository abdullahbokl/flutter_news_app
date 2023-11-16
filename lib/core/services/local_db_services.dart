import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  final SharedPreferences prefs;

  LocalDBServices(this.prefs);

  Future<void> setMap(String key, Map<String, dynamic> favorites) async {
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

  Future<void> set(String key, dynamic value) async {
    try {
      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else {
        throw Exception('Invalid value type');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get(String key) async {
    try {
      final dynamic value = prefs.get(key);
      return value;
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
