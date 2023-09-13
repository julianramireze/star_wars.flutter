import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:star_wars/config/api.dart';
import 'package:star_wars/services/api.dart';
import 'package:star_wars/config/key.dart' as Config;
import 'package:star_wars/services/api.dart';

class StabilityAIService {
  static Future<Response> getStabilityAIResponse(
      {required String text,
      int cfg_scale = 10,
      int height = 1024,
      int width = 1024,
      int samples = 1,
      int steps = 30,
      Function(int, int)? onReceiveProgress}) async {
    final formattedApi = api;
    formattedApi.options.headers['Content-Type'] = 'application/json';
    formattedApi.options.headers['Accept'] = 'image/png';
    formattedApi.options.headers['Authorization'] =
        'Bearer ${Config.Key.stabilityAIKey}';

    return api.post(
        "${Api.baseUrlStabilityAI}${Api.endpointGenerationStabilityAI}stable-diffusion-xl-1024-v1-0/text-to-image",
        data: json.encode({
          "text_prompts": [
            {"text": text}
          ],
          "cfg_scale": cfg_scale,
          "height": height,
          "width": width,
          "samples": samples,
          "steps": steps
        }),
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: onReceiveProgress);
  }
}
