import 'package:flutter/material.dart';
import '../viewmodels/navigation_viewmodel.dart';
import 'custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final NavigationViewModel viewModel;

  HomeScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Navigation Bar MVVM"),
      ),
      body: Center(
        child: Text("Main Content"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomNavigationBar(viewModel: viewModel),
      ),
    );
  }
}