part of 'entities.dart';

@JsonSerializable()
class Character extends Entity with ObjectComparator {
  const Character({
    required this.imageUri,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.id,
    required this.type,
    required this.origin,
    required this.location,
    required this.episodeUrls,
    required this.created,
  }) : super(id: id, name: name);

  /// The id of the character.
  @override
  final int id;

  /// The name of the character.
  @override
  final String name;

  /// The status of the character ('Alive', 'Dead' or 'unknown').
  final String status;

  /// The species of the character.
  final String species;

  /// The type or subspecies of the character.
  final String type;

  /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
  final String gender;

  /// Name and link to the character's origin location.
  @JsonKey(fromJson: _toEntity)
  final Entity? origin;

  /// Name and link to the character's last known location endpoint.
  @JsonKey(fromJson: _toEntity)
  final Entity? location;

  /// Link to the character's image. All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
  @JsonKey(name: 'image')
  final Uri imageUri;

  /// List of episodes in which this character appeared.
  @JsonKey(name: 'episode')
  final List<String> episodeUrls;

  final DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  factory Character.fromDatabase(Map<String, dynamic> map) => Character(
    id: map['id'] as int,
    name: map['name'] as String,
    status: map['status'] as String,
    species: map['species'] as String,
    type: map['type'] as String,
    gender: map['gender'] as String,
    imageUri: Uri.parse(map['image'] as String),
    origin: map['origin_id'] != null ? Entity(id: map['origin_id'] as int, name: map['origin_name'] as String) : null,
    location: map['location_id'] != null ? Entity(id: map['location_id'] as int, name: map['location_name'] as String) : null,
    episodeUrls: (map['episode'] as String).split(','),
    created: DateTime.parse(map['created'] as String),
  );

  Map<String, dynamic> toDatabase() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'image': imageUri.toString(),
    'origin_id': origin?.id,
    'origin_name': origin?.name,
    'location_id': location?.id,
    'location_name': location?.name,
    'episode': episodeUrls.join(','),
    'created': created.toIso8601String(),
  };

  @override
  List<Object> get fields => [imageUri, name, status, species, gender];
}
