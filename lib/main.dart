import 'package:flutter/material.dart';
import 'package:saahasini/viewmodels/auth_viewmodel.dart';
import 'package:saahasini/viewmodels/onboarding_viewmodel.dart';
import 'package:saahasini/views/SettingsScreen.dart';
import 'package:saahasini/views/Shake_Screen.dart';
import 'package:saahasini/views/SpyCam.dart';
import 'package:saahasini/views/articleScreen.dart';
import 'package:saahasini/views/google_map_screen.dart'; // Import the new GoogleMapScreen
import 'package:saahasini/views/home_screen.dart';
import 'package:saahasini/views/notification_screen.dart';
import 'package:saahasini/views/onboarding_screen.dart';
import 'package:saahasini/views/sign_in_screen.dart';
import 'package:saahasini/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboard': (context) => OnboardingScreen(viewModel: OnboardingViewModel(), onComplete: () {

        },),
        '/signup': (context) => SignUpScreen(viewModel: AuthViewModel()),
        '/home': (context) => HomeScreen(),
        '/call': (context) => CallPage(callID: "fake_call_${DateTime.now().millisecondsSinceEpoch}"),
        '/notifications': (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(),
        '/articles': (context) => ArticleScreen(),
        '/map': (context) => GoogleMapScreen(), // Add GoogleMapScreen route
        '/spycam': (context) => SpyCamDetector(), // Add SpyCamDetector route
        '/shakeDemo': (context) => ShakeDemo(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}