import 'package:json_annotation/json_annotation.dart';

part 'person_details_model.g.dart';

@JsonSerializable()
class PersonDetailsModel {
  final bool? adult;
  @JsonKey(name: 'also_known_as')
  final List<String>? alsoKnownAs;
  final String? biography;
  final String? birthday;
  final String? deathday;
  final int? gender;
  final String? homepage;
  final int? id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final String? name;
  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;
  final double? popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  PersonDetailsModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDetailsModelToJson(this);
}