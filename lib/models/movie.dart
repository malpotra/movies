import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';

part 'movie.g.dart';                                                           

@JsonSerializable()
class Movie {
  final bool? adult;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  @JsonKey(name: "belongs_to_collection")
  final String? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  @JsonKey(name: "imdb_id")
  final String? imdbId;
  @JsonKey(name: "original_language")
  final String? orginalLanguage;
  @JsonKey(name: "original_title")
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "production_companies")
  final List<ProductionCompany>? productionCompanies;
  @JsonKey(name: "production_countries")  
  final List<ProductionCountry>? productionCountries;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  @JsonKey(name: "spoken_languages")
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;


  Movie({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.orginalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String,dynamic> toJson() => _$MovieToJson(this);


}