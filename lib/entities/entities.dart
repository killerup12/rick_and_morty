import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/shared/object_comparator/object_comparator.dart';

part 'character.dart';
part 'entities.g.dart';

@JsonSerializable()
class Entity with ObjectComparator {
  const Entity({required this.id, required this.name});

  /// The id of the
  final int id;

  /// The name of the
  final String name;

  @override
  List<Object> get fields => [id, name];

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

Entity? _toEntity(Map<String, dynamic> json) {
  final id = int.tryParse(Uri.parse(json['url']).pathSegments.lastOrNull ?? '');
  final name = json['name'] as String?;
  if (id == null || (name?.isEmpty ?? true)) return null;

  return Entity(id: id, name: name!);
}
