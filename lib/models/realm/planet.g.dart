// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Planet _$PlanetFromJson(Map<String, dynamic> json) => _Planet()
  ..name = json['name'] as String?
  ..rotationPeriod = json['rotationPeriod'] as int?
  ..orbitalPeriod = json['orbitalPeriod'] as int?
  ..diameter = json['diameter'] as int?
  ..climate = json['climate'] as String?
  ..terrain = json['terrain'] as String?
  ..created =
      json['created'] == null ? null : DateTime.parse(json['created'] as String)
  ..edited =
      json['edited'] == null ? null : DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$PlanetToJson(_Planet instance) => <String, dynamic>{
      'name': instance.name,
      'rotationPeriod': instance.rotationPeriod,
      'orbitalPeriod': instance.orbitalPeriod,
      'diameter': instance.diameter,
      'climate': instance.climate,
      'terrain': instance.terrain,
      'created': instance.created?.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
    };

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Planet extends _Planet with RealmEntity, RealmObjectBase, RealmObject {
  Planet({
    String? name,
    int? rotationPeriod,
    int? orbitalPeriod,
    int? diameter,
    String? climate,
    String? terrain,
    DateTime? created,
    DateTime? edited,
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'rotationPeriod', rotationPeriod);
    RealmObjectBase.set(this, 'orbitalPeriod', orbitalPeriod);
    RealmObjectBase.set(this, 'diameter', diameter);
    RealmObjectBase.set(this, 'climate', climate);
    RealmObjectBase.set(this, 'terrain', terrain);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'edited', edited);
  }

  Planet._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  int? get rotationPeriod =>
      RealmObjectBase.get<int>(this, 'rotationPeriod') as int?;
  @override
  set rotationPeriod(int? value) =>
      RealmObjectBase.set(this, 'rotationPeriod', value);

  @override
  int? get orbitalPeriod =>
      RealmObjectBase.get<int>(this, 'orbitalPeriod') as int?;
  @override
  set orbitalPeriod(int? value) =>
      RealmObjectBase.set(this, 'orbitalPeriod', value);

  @override
  int? get diameter => RealmObjectBase.get<int>(this, 'diameter') as int?;
  @override
  set diameter(int? value) => RealmObjectBase.set(this, 'diameter', value);

  @override
  String? get climate =>
      RealmObjectBase.get<String>(this, 'climate') as String?;
  @override
  set climate(String? value) => RealmObjectBase.set(this, 'climate', value);

  @override
  String? get terrain =>
      RealmObjectBase.get<String>(this, 'terrain') as String?;
  @override
  set terrain(String? value) => RealmObjectBase.set(this, 'terrain', value);

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
  Stream<RealmObjectChanges<Planet>> get changes =>
      RealmObjectBase.getChanges<Planet>(this);

  @override
  Planet freeze() => RealmObjectBase.freezeObject<Planet>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Planet._);
    return const SchemaObject(ObjectType.realmObject, Planet, 'Planet', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('rotationPeriod', RealmPropertyType.int, optional: true),
      SchemaProperty('orbitalPeriod', RealmPropertyType.int, optional: true),
      SchemaProperty('diameter', RealmPropertyType.int, optional: true),
      SchemaProperty('climate', RealmPropertyType.string, optional: true),
      SchemaProperty('terrain', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('edited', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
