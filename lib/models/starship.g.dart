// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarShipModel _$StarShipModelFromJson(Map<String, dynamic> json) =>
    StarShipModel()
      ..name = json['name'] as String
      ..model = json['model'] as String
      ..manufacturer = json['manufacturer'] as String
      ..costInCredits =
          const JsonStringToInt().fromJson(json['cost_in_credits'])
      ..length = const JsonStringToDouble().fromJson(json['length'])
      ..maxAtmospheringSpeed =
          const JsonStringToInt().fromJson(json['max_atmosphering_speed'])
      ..cargoCapacity = const JsonStringToInt().fromJson(json['cargo_capacity'])
      ..starshipClass = json['starship_class'] as String
      ..url = json['url'] as String
      ..created = DateTime.parse(json['created'] as String)
      ..edited = DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$StarShipModelToJson(StarShipModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'model': instance.model,
      'manufacturer': instance.manufacturer,
      'cost_in_credits': const JsonStringToInt().toJson(instance.costInCredits),
      'length': const JsonStringToDouble().toJson(instance.length),
      'max_atmosphering_speed':
          const JsonStringToInt().toJson(instance.maxAtmospheringSpeed),
      'cargo_capacity': const JsonStringToInt().toJson(instance.cargoCapacity),
      'starship_class': instance.starshipClass,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited.toIso8601String(),
    };
