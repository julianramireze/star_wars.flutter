import 'package:flutter/material.dart';
import 'package:star_wars/utils/ui/helpers/local_storage_service.dart';

class SettingsStore with ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();
  bool _darkMode = true;
  bool _connectionEnabled = true;

  init() async {
    _darkMode = await localStorageService.get('darkMode') ?? false;
    _connectionEnabled =
        await localStorageService.get('connectionEnabled') ?? true;
    notifyListeners();
  }

  bool get darkMode => _darkMode;
  bool get connectionEnabled => _connectionEnabled;

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    localStorageService.set('darkMode', _darkMode);
    notifyListeners();
  }

  void toggleConnection() {
    _connectionEnabled = !_connectionEnabled;
    localStorageService.set('connectionEnabled', _connectionEnabled);
    notifyListeners();
  }
}
