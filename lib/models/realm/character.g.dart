// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Character _$CharacterFromJson(Map<String, dynamic> json) => _Character()
  ..name = json['name'] as String?
  ..height = json['height'] as int?
  ..mass = json['mass'] as int?
  ..hairColor = json['hairColor'] as String?
  ..eyeColor = json['eyeColor'] as String?
  ..gender = json['gender'] as String?
  ..birthYear = json['birthYear'] as String?
  ..homeWorld = json['homeWorld'] as String?
  ..starShips = json['starShips'] as String?
  ..vehicles = json['vehicles'] as String?
  ..created =
      json['created'] == null ? null : DateTime.parse(json['created'] as String)
  ..edited =
      json['edited'] == null ? null : DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$CharacterToJson(_Character instance) =>
    <String, dynamic>{
      'name': instance.name,
      'height': instance.height,
      'mass': instance.mass,
      'hairColor': instance.hairColor,
      'eyeColor': instance.eyeColor,
      'gender': instance.gender,
      'birthYear': instance.birthYear,
      'homeWorld': instance.homeWorld,
      'starShips': instance.starShips,
      'vehicles': instance.vehicles,
      'created': instance.created?.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
    };

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Character extends _Character
    with RealmEntity, RealmObjectBase, RealmObject {
  Character({
    String? name,
    int? height,
    int? mass,
    String? hairColor,
    String? eyeColor,
    String? gender,
    String? birthYear,
    String? homeWorld,
    String? starShips,
    String? vehicles,
    DateTime? created,
    DateTime? edited,
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'height', height);
    RealmObjectBase.set(this, 'mass', mass);
    RealmObjectBase.set(this, 'hairColor', hairColor);
    RealmObjectBase.set(this, 'eyeColor', eyeColor);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'birthYear', birthYear);
    RealmObjectBase.set(this, 'homeWorld', homeWorld);
    RealmObjectBase.set(this, 'starShips', starShips);
    RealmObjectBase.set(this, 'vehicles', vehicles);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'edited', edited);
  }

  Character._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  int? get height => RealmObjectBase.get<int>(this, 'height') as int?;
  @override
  set height(int? value) => RealmObjectBase.set(this, 'height', value);

  @override
  int? get mass => RealmObjectBase.get<int>(this, 'mass') as int?;
  @override
  set mass(int? value) => RealmObjectBase.set(this, 'mass', value);

  @override
  String? get hairColor =>
      RealmObjectBase.get<String>(this, 'hairColor') as String?;
  @override
  set hairColor(String? value) => RealmObjectBase.set(this, 'hairColor', value);

  @override
  String? get eyeColor =>
      RealmObjectBase.get<String>(this, 'eyeColor') as String?;
  @override
  set eyeColor(String? value) => RealmObjectBase.set(this, 'eyeColor', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String? get birthYear =>
      RealmObjectBase.get<String>(this, 'birthYear') as String?;
  @override
  set birthYear(String? value) => RealmObjectBase.set(this, 'birthYear', value);

  @override
  String? get homeWorld =>
      RealmObjectBase.get<String>(this, 'homeWorld') as String?;
  @override
  set homeWorld(String? value) => RealmObjectBase.set(this, 'homeWorld', value);

  @override
  String? get starShips =>
      RealmObjectBase.get<String>(this, 'starShips') as String?;
  @override
  set starShips(String? value) => RealmObjectBase.set(this, 'starShips', value);

  @override
  String? get vehicles =>
      RealmObjectBase.get<String>(this, 'vehicles') as String?;
  @override
  set vehicles(String? value) => RealmObjectBase.set(this, 'vehicles', value);

  @override
  DateTime? get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime?;
  @override
  set created(DateTime? value) => RealmObjectBase.set(this, 'created', value);

  @override
  DateTime? get edited =>
      RealmObjectBase.get<DateTime>(this, 'edited') as DateTime?;
  @override
  set edited(DateTime? value) => RealmObjectBase.set(this, 'edited', value);

  @override
  Stream<RealmObjectChanges<Character>> get changes =>
      RealmObjectBase.getChanges<Character>(this);

  @override
  Character freeze() => RealmObjectBase.freezeObject<Character>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Character._);
    return const SchemaObject(ObjectType.realmObject, Character, 'Character', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('height', RealmPropertyType.int, optional: true),
      SchemaProperty('mass', RealmPropertyType.int, optional: true),
      SchemaProperty('hairColor', RealmPropertyType.string, optional: true),
      SchemaProperty('eyeColor', RealmPropertyType.string, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('birthYear', RealmPropertyType.string, optional: true),
      SchemaProperty('homeWorld', RealmPropertyType.string, optional: true),
      SchemaProperty('starShips', RealmPropertyType.string, optional: true),
      SchemaProperty('vehicles', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('edited', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
