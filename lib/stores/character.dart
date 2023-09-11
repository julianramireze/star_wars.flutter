import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/services/character.dart';
import 'package:star_wars/utils/helpers/request_state.dart';
import 'package:flutter/foundation.dart';
import 'package:star_wars/main.dart';

class CharacterStore extends ChangeNotifier {
  late dynamic characterStore;

  init() async {
    characterStore = await objectBoxStore.box<CharacterModel>().query().build();
  }

  List<CharacterModel> _characters = [];
  List<CharacterModel> _charactersReported = [];
  List<CharacterModel> _charactersFavorites = [];

  List<CharacterModel> get characters => _characters;
  List<CharacterModel> get charactersReported => _charactersReported;
  List<CharacterModel> get charactersFavorites => _charactersFavorites;

  // characters
  void setCharacters(List<CharacterModel> characters) {
    _characters = characters;
    notifyListeners();
  }

  void addCharacters(List<CharacterModel> characters) {
    _characters.addAll(characters);
    notifyListeners();
  }

  void addCharacter(CharacterModel character) {
    _characters.add(character);
    notifyListeners();
  }

  // characters reported
  void setCharactersReported(List<CharacterModel> characters) {
    _charactersReported = characters;
    notifyListeners();
  }

  void addCharactersReported(List<CharacterModel> characters) {
    _charactersReported.addAll(characters);
    notifyListeners();
  }

  void addCharacterReported(CharacterModel character) {
    _charactersReported.add(character);
    notifyListeners();
  }

  // characters favorites
  void setCharactersFavorites(List<CharacterModel> characters) {
    _charactersFavorites = characters;
    notifyListeners();
  }

  void addCharactersFavorites(List<CharacterModel> characters) {
    _charactersFavorites.addAll(characters);
    notifyListeners();
  }

  void addCharacterFavorites(CharacterModel character) {
    _charactersFavorites.add(character);
    notifyListeners();
  }

  void removeCharacterFavorites(CharacterModel character) {
    _charactersFavorites
        .removeWhere((element) => element.name == character.name);
    notifyListeners();
  }

  late RequestState requestStateGet = RequestState(this);

  Future<void> get(int page) async {
    requestStateGet.setLoading(true);
    requestStateGet.setSuccess(null);
    requestStateGet.setError(-1);

    try {
      final request = await CharacterService.get(page);

      List<CharacterModel> characters = request.data['results']
          .map<CharacterModel>(
              (character) => CharacterModel.fromJson(character))
          .toList();
      addCharacters(characters);

      requestStateGet.setSuccess(request.data);
    } on DioError catch (error) {
      if (kDebugMode) {
        print(error);
      }

      requestStateGet.setError(error.response?.statusCode as int);
    }

    requestStateGet.setLoading(false);
  }
}
