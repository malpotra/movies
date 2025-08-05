
import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';

import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class ApiClient {
  static String apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NWFjN2M4ZTFlMTZmYTFkZjc2YjkzYjg4M2MxZjE0NSIsIm5iZiI6MTc1NDA1NDM1MS4xNTI5OTk5LCJzdWIiOiI2ODhjYmVjZjExYTllZjRmYjc3Y2VhNmEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.9-ovIiCah0j61s-NqcgqZKoEmh98LD9zVrMYb7PUcbk";

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/trending/movie/day")
  Future<dynamic> getTrendingMovies(
    @Query("language") String language,
    @Query("page") int page,
  );

  @GET("/movie/now_playing")
  Future<dynamic> getPlayingMoviesInTheaters(
    @Query("region") String region,
    @Query("page") int page
  );

  @GET("/movie/{id}")
  Future<Movie> getMovieDetails(
    @Path("id") int movieId
  );
}