
import 'package:flutter/material.dart';
import 'views/sign_in_screen.dart';
import 'viewmodels/auth_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
      ),
      home: SignUpScreen(viewModel: AuthViewModel()),
    );
  }
}
