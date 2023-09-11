import 'package:flutter/material.dart';
import 'package:star_wars/models/vehicle.dart';

class VehicleStore extends ChangeNotifier {
  init() async {}

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
