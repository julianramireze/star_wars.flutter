import 'package:realm/realm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'starship.g.dart';

@RealmModel()
@JsonSerializable()
class _StarShip {
  String? name;
  String? model;
  String? manufacturer;
  int? costInCredits;
  double? length;
  int? maxAtmospheringSpeed;
  int? cargoCapacity;
  String? starshipClass;
  DateTime? created;
  DateTime? edited;

  Map<String, dynamic> toJson() => _$StarShipToJson(this);
}
