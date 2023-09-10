// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StarShip _$StarShipFromJson(Map<String, dynamic> json) => _StarShip()
  ..name = json['name'] as String?
  ..model = json['model'] as String?
  ..manufacturer = json['manufacturer'] as String?
  ..costInCredits = json['costInCredits'] as int?
  ..length = (json['length'] as num?)?.toDouble()
  ..maxAtmospheringSpeed = json['maxAtmospheringSpeed'] as int?
  ..cargoCapacity = json['cargoCapacity'] as int?
  ..starshipClass = json['starshipClass'] as String?
  ..created =
      json['created'] == null ? null : DateTime.parse(json['created'] as String)
  ..edited =
      json['edited'] == null ? null : DateTime.parse(json['edited'] as String);

Map<String, dynamic> _$StarShipToJson(_StarShip instance) => <String, dynamic>{
      'name': instance.name,
      'model': instance.model,
      'manufacturer': instance.manufacturer,
      'costInCredits': instance.costInCredits,
      'length': instance.length,
      'maxAtmospheringSpeed': instance.maxAtmospheringSpeed,
      'cargoCapacity': instance.cargoCapacity,
      'starshipClass': instance.starshipClass,
      'created': instance.created?.toIso8601String(),
      'edited': instance.edited?.toIso8601String(),
    };

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class StarShip extends _StarShip
    with RealmEntity, RealmObjectBase, RealmObject {
  StarShip({
    String? name,
    String? model,
    String? manufacturer,
    int? costInCredits,
    double? length,
    int? maxAtmospheringSpeed,
    int? cargoCapacity,
    String? starshipClass,
    DateTime? created,
    DateTime? edited,
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'costInCredits', costInCredits);
    RealmObjectBase.set(this, 'length', length);
    RealmObjectBase.set(this, 'maxAtmospheringSpeed', maxAtmospheringSpeed);
    RealmObjectBase.set(this, 'cargoCapacity', cargoCapacity);
    RealmObjectBase.set(this, 'starshipClass', starshipClass);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'edited', edited);
  }

  StarShip._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  String? get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String?;
  @override
  set manufacturer(String? value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  int? get costInCredits =>
      RealmObjectBase.get<int>(this, 'costInCredits') as int?;
  @override
  set costInCredits(int? value) =>
      RealmObjectBase.set(this, 'costInCredits', value);

  @override
  double? get length => RealmObjectBase.get<double>(this, 'length') as double?;
  @override
  set length(double? value) => RealmObjectBase.set(this, 'length', value);

  @override
  int? get maxAtmospheringSpeed =>
      RealmObjectBase.get<int>(this, 'maxAtmospheringSpeed') as int?;
  @override
  set maxAtmospheringSpeed(int? value) =>
      RealmObjectBase.set(this, 'maxAtmospheringSpeed', value);

  @override
  int? get cargoCapacity =>
      RealmObjectBase.get<int>(this, 'cargoCapacity') as int?;
  @override
  set cargoCapacity(int? value) =>
      RealmObjectBase.set(this, 'cargoCapacity', value);

  @override
  String? get starshipClass =>
      RealmObjectBase.get<String>(this, 'starshipClass') as String?;
  @override
  set starshipClass(String? value) =>
      RealmObjectBase.set(this, 'starshipClass', value);

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
  Stream<RealmObjectChanges<StarShip>> get changes =>
      RealmObjectBase.getChanges<StarShip>(this);

  @override
  StarShip freeze() => RealmObjectBase.freezeObject<StarShip>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(StarShip._);
    return const SchemaObject(ObjectType.realmObject, StarShip, 'StarShip', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
      SchemaProperty('manufacturer', RealmPropertyType.string, optional: true),
      SchemaProperty('costInCredits', RealmPropertyType.int, optional: true),
      SchemaProperty('length', RealmPropertyType.double, optional: true),
      SchemaProperty('maxAtmospheringSpeed', RealmPropertyType.int,
          optional: true),
      SchemaProperty('cargoCapacity', RealmPropertyType.int, optional: true),
      SchemaProperty('starshipClass', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('edited', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
