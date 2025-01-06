import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/joke.dart';
import '../providers/joke_provider.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes =
        Provider.of<JokesProvider>(context).favoriteJokes;
    
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromRGBO(240, 240, 240, 1),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              joke.type.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              joke.setup,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              joke.punchline,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            IconButton(
              icon: Icon(
                favoriteJokes.any((item) => item.id == joke.id) ? Icons.favorite : Icons.favorite_border,
                color: Colors.pink,
              ),
              onPressed: () {
                Provider.of<JokesProvider>(context, listen: false)
                    .toggleFavoriteStatus(joke);
              },
            ),
          ],
        ),
      ),
    );
  }
}
