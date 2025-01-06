import 'package:flutter/material.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:lab2/screens/FavouritesJokes.dart';
import 'package:lab2/screens/JokeByType.dart';
import 'package:lab2/screens/RandomJoke.dart';
import 'package:provider/provider.dart';
import './screens/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> getFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();

  print('FCM Token: $token');
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeLocalNotifications();

  await getFCMToken();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (context) => JokesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/jokes-by-type": (context) => const JokeBytype(),
        "/random-joke": (context) => const RandomJoke(),
        "/favourites-jokes": (context) => const FavoritesScreen(),
      },
    );
  }
}
