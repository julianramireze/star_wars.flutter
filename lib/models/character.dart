import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
part 'character.g.dart';

@Entity()
@JsonSerializable()
@JsonStringToInt()
class CharacterModel {
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
}
