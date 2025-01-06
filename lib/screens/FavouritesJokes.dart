import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/joke_provider.dart';
import '../widgets/JokeCard.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes =
        Provider.of<JokesProvider>(context).favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
        child: Text('No favorite jokes yet!'),
      )
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          return JokeCard(joke: favoriteJokes[index]);
        },
      ),
    );
  }
}
