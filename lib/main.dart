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

// Global notifications plugin instance
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  // Initialize the plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> getFCMToken() async {
  // Get the FCM token
  String? token = await FirebaseMessaging.instance.getToken();

  // Print the token (you can use it for debugging or send it to your server)
  print('FCM Token: $token');

  // You can store the token in a secure location if needed
}

// Handle background notifications
Future<void> backgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications after Firebase setup
  await initializeLocalNotifications();

  await getFCMToken();
  // Configure background message handler for Firebase messaging
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // Run the application
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
