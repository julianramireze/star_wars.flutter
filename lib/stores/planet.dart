import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:star_wars/models/realm/planet.dart';

class PlanetStore extends ChangeNotifier {
  final realm = Realm(Configuration.local([Planet.schema], schemaVersion: 1));

  init() async {
    var planets = realm.all<Planet>().map((planet) => planet.toJson()).toList();
    setPlanets(planets);
  }

  List<dynamic> _planets = [];

  List<dynamic> get planets => _planets;

  void setPlanets(List<dynamic> planets) {
    _planets = planets;
    notifyListeners();
  }

  void addPlanet(Map<String, dynamic> planet) {
    _planets.add(planet);
    notifyListeners();
  }
}
