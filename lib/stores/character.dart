import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/services/character.dart';
import 'package:star_wars/utils/helpers/local_storage_service.dart';
import 'package:star_wars/utils/helpers/request_state.dart';
import 'package:flutter/foundation.dart';
import 'package:star_wars/main.dart';

class CharacterStore extends ChangeNotifier {
  LocalStorageService localStorageService = LocalStorageService();

  init() async {
    final charactersDefault = await localStorageService
            .get(LocalStoreType.charactersDefault.toString()) ??
        [];
    if (charactersDefault.runtimeType == String) {
      setCharacters(jsonDecode(charactersDefault)
          .map<CharacterModel>(
              (character) => CharacterModel.fromJson(character))
          .toList());
    }
    final charactersFavorites = await localStorageService
            .get(LocalStoreType.charactersFavorites.toString()) ??
        [];
    if (charactersFavorites.runtimeType == String) {
      setCharactersFavorites(jsonDecode(charactersFavorites)
          .map<CharacterModel>(
              (character) => CharacterModel.fromJson(character))
          .toList());
    }
    final charactersReported = await localStorageService
            .get(LocalStoreType.charactersReported.toString()) ??
        [];
    if (charactersReported.runtimeType == String) {
      setCharactersReported(jsonDecode(charactersReported)
          .map<CharacterModel>(
              (character) => CharacterModel.fromJson(character))
          .toList());
    }
  }

  List<CharacterModel> _characters = [];
  List<CharacterModel> _charactersFavorites = [];
  List<CharacterModel> _charactersReported = [];

  List<CharacterModel> get characters => _characters;
  List<CharacterModel> get charactersFavorites => _charactersFavorites;
  List<CharacterModel> get charactersReported => _charactersReported;

  // characters
  void setCharacters(List<CharacterModel> characters) {
    _characters = characters;
    notifyListeners();
  }

  void addCharacters(List<CharacterModel> charactersToAdd) {
    List<CharacterModel> charactersFiltered = charactersToAdd
        .where((characterToAdd) => !_characters
            .any((character) => character.name == characterToAdd.name))
        .toList();
    _characters.addAll(charactersFiltered);
    notifyListeners();

    localStorageService.set(LocalStoreType.charactersDefault.toString(),
        json.encode(_characters).toString());
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
  void setCharactersFavorites(List<CharacterModel> characters) {
    _charactersFavorites = characters;
    notifyListeners();
  }

  void addCharactersFavorites(List<CharacterModel> characters) {
    _charactersFavorites.addAll(characters);
    notifyListeners();
  }

  void addCharacterFavorite(CharacterModel character) {
    _charactersFavorites.add(character);
    notifyListeners();

    localStorageService.set(LocalStoreType.charactersFavorites.toString(),
        json.encode(_charactersFavorites).toString());
  }

  void removeCharacterFavorite(CharacterModel character) {
    _charactersFavorites.remove(character);
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

    localStorageService.set(LocalStoreType.charactersReported.toString(),
        json.encode(_charactersReported).toString());
  }

  void removeCharacterReported(CharacterModel character) {
    _charactersReported.remove(character);
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
