import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/services/character.dart';
import 'package:star_wars/utils/helpers/request_state.dart';
import 'package:flutter/foundation.dart';
import 'package:star_wars/main.dart';

class CharacterStore extends ChangeNotifier {
  init() async {}

  List<CharacterModel> _characters = [];
  List<CharacterModel> _charactersFavorites = [];
  List<CharacterModel> _charactersReported = [];

  List<CharacterModel> get characters => _characters;
  List<CharacterModel> get charactersFavorites => _charactersFavorites;
  List<CharacterModel> get charactersReported => _charactersReported;

  // characters
  void addCharacters(List<CharacterModel> characters) {
    _characters.addAll(characters);
    notifyListeners();
  }

  void addCharacter(CharacterModel character) {
    _characters.add(character);
    notifyListeners();
  }

  void removeCharacter(CharacterModel character) {
    _characters.remove(character);
    notifyListeners();
  }

  // characters favorites
  void addCharactersFavorites(List<CharacterModel> characters) {
    _charactersFavorites.addAll(characters);
    notifyListeners();
  }

  void addCharacterFavorite(CharacterModel character) {
    _charactersFavorites.add(character);
    notifyListeners();
  }

  void removeCharacterFavorite(CharacterModel character) {
    _charactersFavorites.remove(character);
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
