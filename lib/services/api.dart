import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';

final _dio = Dio(
  BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      'Accept': '*/*',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    },
  ),
);

Dio get api => _dio;
