import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:star_wars/models/vehicle.dart';
import 'package:star_wars/services/vehicle.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:star_wars/utils/helpers/request_state.dart';

class VehicleStore extends ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();
  init() async {
    final vehicles = await localStorageService
            .get(LocalStoreType.vehiclesDefault.toString()) ??
        [];
    if (vehicles.runtimeType == String) {
      setVehicles(json
          .decode(vehicles)
          .map<VehicleModel>((vehicle) => VehicleModel.fromJson(vehicle))
          .toList());
    }
  }

  List<VehicleModel> _vehicles = [];

  List<VehicleModel> get vehicles => _vehicles;

  void setVehicles(List<VehicleModel> vehicles) {
    _vehicles = vehicles;
    notifyListeners();
  }

  void addVehicles(List<VehicleModel> vehiclesToAdd) {
    List<VehicleModel> vehiclesFiltered = vehiclesToAdd.where((vehicleToAdd) {
      return !vehicles.any((vehicle) => vehicle.name == vehicleToAdd.name);
    }).toList();

    _vehicles.addAll(vehiclesFiltered);
    notifyListeners();

    localStorageService.set(LocalStoreType.vehiclesDefault.toString(),
        json.encode(_vehicles).toString());
  }

  late RequestState requestStateGetByID = RequestState(this);

  Future<void> getByID(String id) async {
    requestStateGetByID.setLoading(RequestStateLoadingType.loading);
    requestStateGetByID.setSuccess(RequestStateSuccessType.none);
    requestStateGetByID.setError(RequestStateErrorType.none);

    try {
      final request = await VehicleService.getByID(id);

      VehicleModel planet = VehicleModel.fromJson(request.data);
      addVehicles([planet].toList());

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
