// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle()
  ..name = json['name'] as String
  ..model = json['model'] as String
  ..manufacturer = json['manufacturer'] as String
  ..costInCredits = const JsonStringToInt().fromJson(json['cost_in_credits'])
  ..length = (json['length'] as num).toDouble()
  ..maxAtmospheringSpeed =
      const JsonStringToInt().fromJson(json['max_atmosphering_speed'])
  ..cargoCapacity = const JsonStringToInt().fromJson(json['cargo_capacity'])
  ..vehicleClass = json['vehicle_class'] as String
  ..created = DateTime.parse(json['created'] as String)
  ..edited = DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'name': instance.name,
      'model': instance.model,
      'manufacturer': instance.manufacturer,
      'cost_in_credits': const JsonStringToInt().toJson(instance.costInCredits),
      'length': instance.length,
      'max_atmosphering_speed':
          const JsonStringToInt().toJson(instance.maxAtmospheringSpeed),
      'cargo_capacity': const JsonStringToInt().toJson(instance.cargoCapacity),
      'vehicle_class': instance.vehicleClass,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited.toIso8601String(),
    };
