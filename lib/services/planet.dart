import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/services/api.dart';

class PlanetService {
  static Future<Response<dynamic>> getByID(String id) =>
      api.get('${Api.endpointPlanets}$id');
}
