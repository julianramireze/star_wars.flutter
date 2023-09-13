import 'package:json_annotation/json_annotation.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToDouble.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
part 'starship.g.dart';

@JsonSerializable()
@JsonStringToInt()
@JsonStringToDouble()
class StarShipModel {
  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'model')
  late String model;

  @JsonKey(name: 'manufacturer')
  late String manufacturer;

  @JsonKey(name: 'cost_in_credits')
  late int costInCredits;

  @JsonKey(name: 'length')
  late double length;

  @JsonKey(name: 'max_atmosphering_speed')
  late int maxAtmospheringSpeed;

  @JsonKey(name: 'cargo_capacity')
  late int cargoCapacity;

  @JsonKey(name: 'starship_class')
  late String starshipClass;

  @JsonKey(name: 'url')
  late String url;

  @JsonKey(name: 'created')
  late DateTime created;

  @JsonKey(name: 'edited')
  late DateTime edited;

  static StarShipModel fromJson(Map<String, dynamic> json) =>
      _$StarShipModelFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipModelToJson(this);
}
