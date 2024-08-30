import 'package:flutter/material.dart';
import 'package:saahasini/views/home_screen.dart';
import 'package:saahasini/views/live_tracking_screen.dart';
import 'package:saahasini/views/notification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification UI',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/live-tracking': (context) => LiveTrackingScreen(),  // Add this route
      },
    );
  }
}
