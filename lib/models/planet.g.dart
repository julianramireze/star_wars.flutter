// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanetModel _$PlanetModelFromJson(Map<String, dynamic> json) => PlanetModel()
  ..name = json['name'] as String
  ..rotationPeriod = const JsonStringToInt().fromJson(json['rotation_period'])
  ..orbitalPeriod = const JsonStringToInt().fromJson(json['orbital_period'])
  ..diameter = const JsonStringToInt().fromJson(json['diameter'])
  ..climate = json['climate'] as String
  ..terrain = json['terrain'] as String
  ..created = DateTime.parse(json['created'] as String)
  ..edited = DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$PlanetModelToJson(PlanetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rotation_period':
          const JsonStringToInt().toJson(instance.rotationPeriod),
      'orbital_period': const JsonStringToInt().toJson(instance.orbitalPeriod),
      'diameter': const JsonStringToInt().toJson(instance.diameter),
      'climate': instance.climate,
      'terrain': instance.terrain,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited.toIso8601String(),
    };
