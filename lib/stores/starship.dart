import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:star_wars/models/realm/starship.dart';

class StarShipStore extends ChangeNotifier {
  final realm = Realm(Configuration.local([StarShip.schema], schemaVersion: 1));

  init() async {
    var starShip =
        realm.all<StarShip>().map((starShip) => starShip.toJson()).toList();
    setStarShips(starShip);
  }

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
