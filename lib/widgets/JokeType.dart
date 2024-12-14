import 'package:flutter/material.dart';
import 'package:lab2/services/api_service.dart';

class JokeType extends StatelessWidget {
  final String type;

  const JokeType ({required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromRGBO(240, 240, 240, 1),
      child: ListTile(
        title: Text(type),
        onTap: () => {
          Navigator.pushNamed(context, "/jokes-by-type",
              arguments: type
          )
        },
      )
    );
  }
}
