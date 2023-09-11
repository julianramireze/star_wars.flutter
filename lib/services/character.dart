import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/services/api.dart';

class CharacterService {
  static Future<Response<dynamic>> get(int page) =>
      api.get('${Api.endpointPeople}?page=$page');
}
