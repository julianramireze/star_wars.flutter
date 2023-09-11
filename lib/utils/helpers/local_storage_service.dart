import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? sharedPreferences;

  Future<void> setup() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> set(String key, dynamic value) async {
    switch (value?.runtimeType) {
      case bool:
        await sharedPreferences?.setBool(key, value);
        break;
      case int:
        await sharedPreferences?.setInt(key, value);
        break;
      case double:
        await sharedPreferences?.setDouble(key, value);
        break;
      case String:
        await sharedPreferences?.setString(key, value);
        break;
    }
  }

  Future<dynamic> get(String key) async {
    switch (sharedPreferences?.get(key).runtimeType) {
      case bool:
        return sharedPreferences?.getBool(key);
      case int:
        return sharedPreferences?.getInt(key);
      case double:
        return sharedPreferences?.getDouble(key);
      case String:
        return sharedPreferences?.getString(key);
      default:
        return null;
    }
  }

  Future<void> delete(String key) async {
    await sharedPreferences?.remove(key);
  }
}
