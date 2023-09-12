// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: json['id'] == null ? 0 : const JsonStringToInt().fromJson(json['id']),
      name: json['name'] as String,
      height: const JsonStringToInt().fromJson(json['height']),
      mass: const JsonStringToInt().fromJson(json['mass']),
      hairColor: json['hair_color'] as String,
      eyeColor: json['eye_color'] as String,
      gender: json['gender'] as String,
      birthYear: json['birth_year'] as String,
      homeWorld: json['homeworld'] as String,
      starShips:
          (json['starships'] as List<dynamic>).map((e) => e as String).toList(),
      vehicles:
          (json['vehicles'] as List<dynamic>).map((e) => e as String).toList(),
      created: DateTime.parse(json['created'] as String),
      edited: DateTime.parse(json['edited'] as String),
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': const JsonStringToInt().toJson(instance.id),
      'name': instance.name,
      'height': const JsonStringToInt().toJson(instance.height),
      'mass': const JsonStringToInt().toJson(instance.mass),
      'hair_color': instance.hairColor,
      'eye_color': instance.eyeColor,
      'gender': instance.gender,
      'birth_year': instance.birthYear,
      'homeworld': instance.homeWorld,
      'starships': instance.starShips,
      'vehicles': instance.vehicles,
      'created': instance.created.toIso8601String(),
      'edited': instance.edited.toIso8601String(),
    };
