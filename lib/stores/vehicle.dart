import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:star_wars/models/realm/vehicle.dart';

class VehicleStore extends ChangeNotifier {
  final realm = Realm(Configuration.local([Vehicle.schema], schemaVersion: 1));

  init() async {
    var vehicles =
        realm.all<Vehicle>().map((vehicle) => vehicle.toJson()).toList();
    setVehicles(vehicles);
  }

  List<dynamic> _vehicles = [];

  List<dynamic> get vehicles => _vehicles;

  void setVehicles(List<dynamic> vehicles) {
    _vehicles = vehicles;
    notifyListeners();
  }

  void addVehicle(Map<String, dynamic> vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }
}
