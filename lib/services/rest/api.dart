import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';

final _dio = Dio(
  BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: const Duration(seconds: 10),
  ),
);

Dio get api => _dio;
