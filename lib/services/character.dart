import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/services/api.dart';

class CharacterService {
  static Future<Response<dynamic>> get(int page) =>
      api.get('${Api.endpointPeople}?page=$page');

  static Future<Response<dynamic>> report(
      int id, String dateTime, String characterName) {
    return api.post('${Api.baseUrlJsonPlaceholder}posts',
        data: json.encode({
          "userId": id,
          "dateTime": dateTime,
          "characterName": characterName
        }).toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
  }
}
