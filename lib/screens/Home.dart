import 'package:flutter/material.dart';
import 'package:lab2/services/api_service.dart';
import 'package:lab2/widgets/JokeType.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  List<String> jokesTypes = [];


  @override
  void initState() {
    super.initState();
    fetchJokesTypes();
  }

  Future<void> fetchJokesTypes() async {
    try {
      List<String> fetchedJokes = await apiService.getJokesType();
      setState(() {
        jokesTypes = fetchedJokes;
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
        TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/random-joke');
            },
            child: const Text("Random Joke", style: TextStyle(color: Colors.lime, fontSize: 16),),
          ),
        ],
      ),
      body: jokesTypes.isEmpty ?
        const Center(child: CircularProgressIndicator()) :
        ListView.builder(
          itemCount: jokesTypes.length,
          itemBuilder: (context, index){
            final jokeType = jokesTypes[index];
            return JokeType(type: jokeType);
          },
        ),
    );
  }
}