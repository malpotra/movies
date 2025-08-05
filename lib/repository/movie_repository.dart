

import 'package:movies_app/apis/api_client.dart';
import 'package:movies_app/models/movie.dart';
// import 'package:hive_ce/hive.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MovieRepository {

  // final _movieBox = Hive.openBox('movie_box');
  final api = ApiClient(Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        "Authorization": "Bearer ${ApiClient.apiKey}",
        "accept": "application/json"
      },
      connectTimeout: Duration(seconds: 10),receiveTimeout: Duration(seconds: 10)
    )
  ));

  MovieRepository();


  Future<List<dynamic>> fetchTrendingMovies(String language, int page) async {
    //Not Working
    // int retry = 0;
    // while (retry <= 3) {
    //   try {
    //     dynamic result = await api.getTrendingMovies(language, page);
    //     print(result);
    //     return List.empty();
    //   } catch (e) {
    //     print(e);
    //     retry++;
    //     if (retry <= 3) {
    //       await Future.delayed(Duration(seconds: 5));
    //     } else 
    //       return List.empty();
    //   }
    // }
    // return List.empty();

    final url = Uri.parse('https://api.themoviedb.org/3/trending/movie/day?language=${language}&page=${page}');
    int retry = 0;
    while (retry <= 3) {
      try {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${ApiClient.apiKey}',
            'accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(data);
          return data['results'];
        } else {
          print('Failed to fetch: ${response.statusCode}');
        }
        return List.empty();
      } catch (e) {
        print(e);
        if (retry <= 3) {
          retry++;
          await Future.delayed(Duration(seconds: 1));
        } else {
          break;
        }
      }
    }
    return List.empty();

  }
  Future<List<dynamic>> fetchMoviesPlayingInTheaters(String region, int page) async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/now_playing?region=${region}&page=${page}');
    int retry = 0;
    while (retry <= 5) {
      try {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${ApiClient.apiKey}',
            'accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(data);
          return data['results'];
        } else {
          print('Failed to fetch: ${response.statusCode}');
        }
        return List.empty();
      } catch (e) {
        print(e);
        if (retry <= 3) {
          retry++;
          await Future.delayed(Duration(seconds: 1));
        } else {
          break;
        }
      }
    }
    return List.empty();

  }

  Future<List<Movie>> fetchMovieByQuery(String userQuery) {
    throw UnimplementedError("Not implemented");

  }

  Future<Movie> fetchMovieById(int movieId) {
    throw UnimplementedError("Not implemented");

  }

}