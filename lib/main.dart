import 'package:flutter/material.dart';
import 'package:saahasini/viewmodels/auth_viewmodel.dart';
import 'package:saahasini/views/home_screen.dart';
import 'package:saahasini/views/live_tracking_screen.dart';
import 'package:saahasini/views/notification_screen.dart';
import 'package:saahasini/views/sign_in_screen.dart';

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
        '/': (context) => SignUpScreen(viewModel: AuthViewModel()),
        '/notifications': (context) => NotificationScreen(),
        '/live-tracking': (context) => LiveTrackingScreen(),  // Add this route
      },
    );
  }
}
