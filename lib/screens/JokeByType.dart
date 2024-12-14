import 'package:flutter/material.dart';
import 'package:lab2/models/joke.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/widgets/JokeCard.dart';

class JokeBytype extends StatefulWidget {
  const JokeBytype({super.key});

  @override
  State<JokeBytype> createState() => _HomeState();
}

class _HomeState extends State<JokeBytype> {
  ApiService apiService = ApiService();
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String type = ModalRoute.of(context)!.settings.arguments as String;
      fetchJokesByTypes(type);
    });
  }

  Future<void> fetchJokesByTypes(String type) async {
    try {
      List<Joke> fetchedJokes = await apiService.getJokesFromType(type);
      setState(() {
        jokes = fetchedJokes;
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
      body: jokes.isEmpty ?
        const Center(child: CircularProgressIndicator()) :
        ListView.builder(
          itemCount: jokes.length,
          itemBuilder: (context, index){
            final joke = jokes[index];
            return JokeCard(joke: joke);
          },
        ),
    );
  }
}