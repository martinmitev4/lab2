import 'package:flutter/material.dart';
import '../models/joke.dart';

class JokesProvider with ChangeNotifier {
  final List<Joke> favoriteJokes = [];

  void addJokeFavorite(Joke joke) {
    favoriteJokes.add(joke);
    notifyListeners();
  }
  void removeJokeFavorite(Joke joke) {
    favoriteJokes.removeWhere((item) => item.id == joke.id);
    notifyListeners();
  }

  void toggleFavoriteStatus(Joke joke) {
    if (favoriteJokes.any((item) => item.id == joke.id)){
      removeJokeFavorite(joke);
    }
    else {
      addJokeFavorite(joke);
    }
  }
}
