import 'package:flutter/widgets.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/repository/movie_repository.dart';


class HomeViewModel with ChangeNotifier {
  late MovieRepository _movieRepository;
  bool _isLoading = false;


  bool get isLoading => _isLoading;

  HomeViewModel() {
    _movieRepository = MovieRepository();
    
  }

  Future <List<dynamic>> fetchTrendingMovies(String language, int page) async {
    try {
      _isLoading = true;
      notifyListeners();
      return await _movieRepository.fetchTrendingMovies(language, page);
    } catch (e) {
      print(e);
      return List.empty();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<dynamic>> fetchMoviesPlayingInTheaters(String region, int page ) async {
    try {
      return await _movieRepository.fetchMoviesPlayingInTheaters(region, page);
    } catch (e) {
      print(e);
      return List.empty();
    } finally {
    }
  }

  Future <Movie> fetchMovieDetails(int movieId) async {
    try {
      _isLoading = true;
      notifyListeners();
      return await _movieRepository.fetchMovieById(movieId);
    } catch (e) {
      print(e);
      return Future.value(null);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}