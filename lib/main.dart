import 'package:flutter/material.dart';
import 'package:saahasini/views/SettingsScreen.dart';
import 'package:saahasini/views/articleScreen.dart';
import 'package:saahasini/views/home_screen.dart';
import 'package:saahasini/views/notification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(), // Register the SettingsScreen
        '/articles': (context) => ArticleScreen(), // Example, replace with your actual screen
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
