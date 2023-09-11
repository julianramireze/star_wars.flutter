import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:star_wars/utils/helpers/JsonSerializable/JsonStringToInt.dart';
part 'planet.g.dart';

@Entity()
@JsonSerializable()
@JsonStringToInt()
class PlanetModel {
  @Id()
  @JsonKey(includeToJson: false, includeFromJson: false)
  late int id;

  @JsonKey(name: 'name')
  late String name;

  @JsonKey(name: 'rotation_period')
  late int rotationPeriod;

  @JsonKey(name: 'orbital_period')
  late int orbitalPeriod;

  @JsonKey(name: 'diameter')
  late int diameter;

  @JsonKey(name: 'climate')
  late String climate;

  @JsonKey(name: 'terrain')
  late String terrain;

  @JsonKey(name: 'created')
  late DateTime created;

  @JsonKey(name: 'edited')
  late DateTime edited;

  static PlanetModel fromJson(Map<String, dynamic> json) =>
      _$PlanetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanetModelToJson(this);
}
