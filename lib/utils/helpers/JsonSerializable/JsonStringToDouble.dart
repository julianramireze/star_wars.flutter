import 'package:json_annotation/json_annotation.dart';

class JsonStringToDouble implements JsonConverter<double, dynamic> {
  const JsonStringToDouble();

  @override
  double fromJson(dynamic json) {
    if (json is num) {
      return json.toDouble();
    }
    return double.tryParse(json) ?? 0;
  }

  @override
  String toJson(double object) => object.toString();
}
