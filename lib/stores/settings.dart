import 'package:flutter/material.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsStore with ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();
  bool _darkMode = true;
  bool _connectionEnabled = true;
  late String _language = "en";

  init() async {
    _darkMode = await localStorageService.get('darkMode') ?? true;
    _connectionEnabled =
        await localStorageService.get('connectionEnabled') ?? true;
    notifyListeners();
  }

  bool get darkMode => _darkMode;
  bool get connectionEnabled => _connectionEnabled;
  String get language => _language;

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
    localStorageService.set('darkMode', _darkMode);
  }

  void toggleConnection() {
    _connectionEnabled = !_connectionEnabled;
    notifyListeners();
    localStorageService.set('connectionEnabled', _connectionEnabled);
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
    localStorageService.set('language', _language);
  }
}
