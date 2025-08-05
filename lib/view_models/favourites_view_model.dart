import 'package:flutter/widgets.dart';


class FavouritesViewModel with ChangeNotifier {
  
  final Set<String> _favorites = Set<String>();

  Set<String> get favorites => Set.unmodifiable(_favorites);

  void add(String movie) {
    if (!_favorites.contains(movie)) {
      _favorites.add(movie);
      notifyListeners();
    }
  }

  void remove(String movie) {
    _favorites.remove(movie);
    notifyListeners();
  }
  bool isFavMovie(String movie) {
    return _favorites.contains(movie);
  }

}