import 'package:flutter/material.dart';
import 'views/onboarding_screen.dart';
import 'viewmodels/onboarding_viewmodel.dart';
import 'views/home_screen.dart';
import 'viewmodels/navigation_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Using a conditional to check if onboarding is needed
      home: OnboardingWrapper(),
    );
  }
}

class OnboardingWrapper extends StatefulWidget {
  @override
  _OnboardingWrapperState createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  bool _isOnboardingComplete = false;

  void _completeOnboarding() {
    setState(() {
      _isOnboardingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnboardingComplete) {
      return HomeScreen(viewModel: NavigationViewModel());
    } else {
      return OnboardingScreen(
        viewModel: OnboardingViewModel(),
        onComplete: _completeOnboarding,
      );
    }
  }
}