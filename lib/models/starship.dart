import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
part 'starship.g.dart';

@Entity()
@JsonSerializable()
@JsonStringToInt()
class StarShip {
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

  @JsonKey(name: 'created')
  late DateTime created;

  @JsonKey(name: 'edited')
  late DateTime edited;

  static StarShip fromJson(Map<String, dynamic> json) =>
      _$StarShipFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipToJson(this);
}
