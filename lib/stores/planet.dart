import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:star_wars/models/planet.dart';
import 'package:star_wars/services/planet.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:star_wars/utils/helpers/request_state.dart';

class PlanetStore extends ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();
  init() async {
    final planets = await localStorageService
            .get(LocalStoreType.planetsDefault.toString()) ??
        [];
    if (planets.runtimeType == String) {
      setPlanets(json
          .decode(planets)
          .map<PlanetModel>((planet) => PlanetModel.fromJson(planet))
          .toList());
    }
  }

  List<PlanetModel> _planets = [];

  List<PlanetModel> get planets => _planets;

  void setPlanets(List<PlanetModel> planets) {
    _planets = planets;
    notifyListeners();
  }

  void addPlanets(List<PlanetModel> planetsToAdd) {
    List<PlanetModel> planetsFiltered = planetsToAdd.where((planetToAdd) {
      return !planets.any((planet) => planet.name == planetToAdd.name);
    }).toList();

    _planets.addAll(planetsFiltered);
    notifyListeners();

    localStorageService.set(LocalStoreType.planetsDefault.toString(),
        json.encode(_planets).toString());
  }

  late RequestState requestStateGetByID = RequestState(this);

  Future<void> getByID(String id) async {
    requestStateGetByID.setLoading(RequestStateLoadingType.loading);
    requestStateGetByID.setSuccess(RequestStateSuccessType.none);
    requestStateGetByID.setError(RequestStateErrorType.none);

    try {
      final request = await PlanetService.getByID(id);

      PlanetModel planet = PlanetModel.fromJson(request.data);
      addPlanets([planet].toList());

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
