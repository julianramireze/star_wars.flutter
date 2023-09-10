import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:star_wars/models/realm/character.dart';

class CharacterStore extends ChangeNotifier {
  final realm =
      Realm(Configuration.local([Character.schema], schemaVersion: 1));

  init() async {
    var characters =
        realm.all<Character>().map((character) => character.toJson()).toList();
    setCharacters(characters);
  }

  List<dynamic> _characters = [];

  List<dynamic> get characters => _characters;

  void setCharacters(List<dynamic> characters) {
    _characters = characters;
    notifyListeners();
  }

  void addCharacter(Map<String, dynamic> character) {
    _characters.add(character);
    notifyListeners();
  }
}
