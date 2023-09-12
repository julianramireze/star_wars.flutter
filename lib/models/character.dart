import 'package:json_annotation/json_annotation.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
import 'package:uuid/uuid.dart';
part 'character.g.dart';

@JsonSerializable()
@JsonStringToInt()
class CharacterModel {
  @JsonKey(name: 'id', defaultValue: 0)
  late int id;

  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'height')
  late int height;

  @JsonKey(name: 'mass')
  late int mass;

  @JsonKey(name: 'hair_color')
  late String hairColor;

  @JsonKey(name: 'eye_color')
  late String eyeColor;

  @JsonKey(name: 'gender')
  late String gender;

  @JsonKey(name: 'birth_year')
  late String birthYear;

  @JsonKey(name: 'homeworld')
  late String homeWorld;

  @JsonKey(name: 'starships')
  late List<String> starShips;

  @JsonKey(name: 'vehicles')
  late List<String> vehicles;

  @JsonKey(name: 'created')
  late DateTime created;

  @JsonKey(name: 'edited')
  late DateTime edited;

  static CharacterModel fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterModel({
    required this.id,
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.eyeColor,
    required this.gender,
    required this.birthYear,
    required this.homeWorld,
    required this.starShips,
    required this.vehicles,
    required this.created,
    required this.edited,
  }) {
    if (id == 0) {
      id = int.parse(const Uuid().v4().toString().substring(0, 8), radix: 16);
    }
  }
}
