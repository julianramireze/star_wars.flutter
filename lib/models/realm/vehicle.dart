import 'package:realm/realm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicle.g.dart';

@RealmModel()
@JsonSerializable()
class _Vehicle {
  String? name;
  String? model;
  String? manufacturer;
  int? costInCredits;
  double? length;
  int? maxAtmospheringSpeed;
  int? cargoCapacity;
  String? vehicleClass;
  DateTime? created;
  DateTime? edited;

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
