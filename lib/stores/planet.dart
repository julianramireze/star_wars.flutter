import 'package:flutter/material.dart';
import 'package:star_wars/models/planet.dart';

class PlanetStore extends ChangeNotifier {
  init() async {}

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
