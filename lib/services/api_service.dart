import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/joke.dart';


class ApiService{

  Future<List<String>> getJokesType() async {
    var response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    if (response.statusCode == 200){
      return List<String>.from(json.decode(response.body));
    }
    else{
      throw Exception('Fail to fetch jokes type');
    }
  }

  Future<List<Joke>> getJokesFromType(String type) async {
    var response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));
    if (response.statusCode == 200){
      return (json.decode(response.body) as List)
      .map((joke) => Joke.fromJson(joke))
      .toList();
    }
    else{
      throw Exception('Fail to fetch jokes of type: $type');
    }
  }

  Future<Joke> getRandomJoke() async {
    var response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    if (response.statusCode == 200){
      return Joke.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Fail to fetch random joke');
    }
  }
}
