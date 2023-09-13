import 'package:json_annotation/json_annotation.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
part 'vehicle.g.dart';

@JsonSerializable()
@JsonStringToInt()
class VehicleModel {
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

  @JsonKey(name: 'vehicle_class')
  late String vehicleClass;

  @JsonKey(name: 'url')
  late String url;

  @JsonKey(name: 'created')
  late DateTime created;

  @JsonKey(name: 'edited')
  late DateTime edited;

  static VehicleModel fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
