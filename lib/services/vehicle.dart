import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/services/api.dart';

class VehicleService {
  static Future<Response<dynamic>> getByID(String id) =>
      api.get('${Api.endpointVehicles}$id');
}
