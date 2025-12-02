// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entity _$EntityFromJson(Map<String, dynamic> json) =>
    Entity(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
  imageUri: Uri.parse(json['image'] as String),
  name: json['name'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  gender: json['gender'] as String,
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  origin: _toEntity(json['origin'] as Map<String, dynamic>),
  location: _toEntity(json['location'] as Map<String, dynamic>),
  episodeUrls: (json['episode'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  created: DateTime.parse(json['created'] as String),
);

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
  'species': instance.species,
  'type': instance.type,
  'gender': instance.gender,
  'origin': instance.origin,
  'location': instance.location,
  'image': instance.imageUri.toString(),
  'episode': instance.episodeUrls,
  'created': instance.created.toIso8601String(),
};
