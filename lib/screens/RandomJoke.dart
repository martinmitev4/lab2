import 'package:flutter/material.dart';
import 'package:lab2/models/joke.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/widgets/JokeCard.dart';

class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _HomeState();
}

class _HomeState extends State<RandomJoke> {
  ApiService apiService = ApiService();
  Joke? joke;

  @override
  void initState() {
    super.initState();
    fetchRandomJoke();
  }

  Future<void> fetchRandomJoke() async {
    try {
      Joke fetchedJoke = await apiService.getRandomJoke();
      setState(() {
        joke = fetchedJoke;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching jokes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo,
          title: const Text("216040", style:
          TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold))
      ),
      body: joke == null ?
        const Center(child: CircularProgressIndicator()) :
        JokeCard(joke: joke!)

    );
  }
}