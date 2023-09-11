import 'package:flutter/material.dart';
import 'package:star_wars/models/starship.dart';

class StarShipStore extends ChangeNotifier {
  init() async {}

  List<dynamic> _starShips = [];

  List<dynamic> get starShips => _starShips;

  void setStarShips(List<dynamic> starShips) {
    _starShips = starShips;
    notifyListeners();
  }

  void addStarShip(Map<String, dynamic> starShip) {
    _starShips.add(starShip);
    notifyListeners();
  }
}
