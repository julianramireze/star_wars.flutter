import 'package:flutter/cupertino.dart';

class RequestState extends ChangeNotifier {
  ChangeNotifier instance;
  bool _loading;
  dynamic _success;
  int _error;
  dynamic _data;

  RequestState(
    this.instance, {
    bool loading = false,
    dynamic success,
    int error = -1,
    dynamic data,
  })  : _loading = loading,
        _success = success,
        _error = error,
        _data = data;

  bool get loading => _loading;
  dynamic get success => _success;
  int get error => _error;
  dynamic get data => _data;

  void setLoading(bool loading) {
    _loading = loading;
    instance.notifyListeners();
  }

  void setSuccess(dynamic success) {
    _success = success;
    instance.notifyListeners();
  }

  void setError(int error) {
    _error = error;
    instance.notifyListeners();
  }

  void setData(dynamic data) {
    _data = data;
    instance.notifyListeners();
  }

  void clear() {
    _loading = false;
    _success = null;
    _error = -1;
    _data = null;
    instance.notifyListeners();
  }
}
