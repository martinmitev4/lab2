import 'package:flutter/material.dart';
import 'package:lab2/screens/JokeByType.dart';
import 'package:lab2/screens/RandomJoke.dart';
import './screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Jokes',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/jokes-by-type": (context) => const JokeBytype(),
        "/random-joke": (context) => const RandomJoke(),
      },
    );
  }
}