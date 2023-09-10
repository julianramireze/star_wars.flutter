import 'package:realm/realm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'planet.g.dart';

@RealmModel()
@JsonSerializable()
class _Planet {
  String? name;
  int? rotationPeriod;
  int? orbitalPeriod;
  int? diameter;
  String? climate;
  String? terrain;
  DateTime? created;
  DateTime? edited;

  Map<String, dynamic> toJson() => _$PlanetToJson(this);
}
