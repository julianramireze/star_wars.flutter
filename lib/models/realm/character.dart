import 'package:realm/realm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@RealmModel()
@JsonSerializable()
class _Character {
  String? name;
  int? height;
  int? mass;
  String? hairColor;
  String? eyeColor;
  String? gender;
  String? birthYear;
  String? homeWorld;
  String? starShips;
  String? vehicles;
  DateTime? created;
  DateTime? edited;

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
