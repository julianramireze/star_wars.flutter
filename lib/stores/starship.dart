import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:star_wars/models/starship.dart';
import 'package:star_wars/services/starship.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:star_wars/utils/helpers/request_state.dart';

class StarShipStore extends ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();
  init() async {
    final starShips = await localStorageService
            .get(LocalStoreType.starShipsDefault.toString()) ??
        [];
    if (starShips.runtimeType == String) {
      setStarShips(json
          .decode(starShips)
          .map<StarShipModel>((starShip) => StarShipModel.fromJson(starShip))
          .toList());
    }
  }

  List<StarShipModel> _starShips = [];

  List<StarShipModel> get starShips => _starShips;

  void setStarShips(List<StarShipModel> starShips) {
    _starShips = starShips;
    notifyListeners();
  }

  void addStarShips(List<StarShipModel> starShipsToAdd) {
    List<StarShipModel> starShipsFiltered =
        starShipsToAdd.where((starShipToAdd) {
      return !starShips.any((starShip) => starShip.name == starShipToAdd.name);
    }).toList();

    _starShips.addAll(starShipsFiltered);
    notifyListeners();

    localStorageService.set(LocalStoreType.starShipsDefault.toString(),
        json.encode(_starShips).toString());
  }

  late RequestState requestStateGetByID = RequestState(this);

  Future<void> getByID(String id) async {
    requestStateGetByID.setLoading(RequestStateLoadingType.loading);
    requestStateGetByID.setSuccess(RequestStateSuccessType.none);
    requestStateGetByID.setError(RequestStateErrorType.none);

    try {
      final request = await StarShipService.getByID(id);

      StarShipModel planet = StarShipModel.fromJson(request.data);
      addStarShips([planet].toList());

      requestStateGetByID.setSuccess(request.data);
    } on DioError catch (error) {
      if (kDebugMode) {
        print(error);
      }

      if (await InternetConnectionChecker().hasConnection) {
        requestStateGetByID.setError(error.response?.statusCode as int);
      } else {
        requestStateGetByID.setError(RequestStateErrorType.noInternet);
      }
    }

    requestStateGetByID.setLoading(RequestStateLoadingType.noLoading);
  }
}
