import 'package:json_annotation/json_annotation.dart';

part 'people_model.g.dart';

@JsonSerializable()
class PeopleModel {
  final int? page;
  final List<PersonResult>? results;
  @JsonKey(name: 'total_results')
  final int? totalResults;
  @JsonKey(name: 'total_pages')
  final int? totalPages;

  PeopleModel({
    this.page,
    this.results,
    this.totalResults,
    this.totalPages,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);
}

@JsonSerializable()
class PersonResult {
  final bool? adult;
  final int? gender;
  final int? id;
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;
  final String? name;
  @JsonKey(name: 'original_name')
  final String? originalName;
  final double? popularity;
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @JsonKey(name: 'known_for')
  final List<KnownForItem>? knownFor;

  PersonResult({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  factory PersonResult.fromJson(Map<String, dynamic> json) =>
      _$PersonResultFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResultToJson(this);
}

@JsonSerializable()
class KnownForItem {
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? name; // For TV shows
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'original_name')
  final String? originalName; // For TV shows
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final double? popularity;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate; // For TV shows
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry; // For TV shows

  KnownForItem({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.firstAirDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  factory KnownForItem.fromJson(Map<String, dynamic> json) =>
      _$KnownForItemFromJson(json);

  Map<String, dynamic> toJson() => _$KnownForItemToJson(this);

}