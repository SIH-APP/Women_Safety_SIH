import 'package:flutter/material.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/nav_item_widget.dart';

class CustomNavigationBar extends StatelessWidget {
  final NavigationViewModel viewModel;

  CustomNavigationBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(viewModel.items.length, (index) {
              final item = viewModel.items[index];
              return GestureDetector(
                onTap: () {
                  viewModel.selectItem(index);
                },
                child: NavItemWidget(item: item),
              );
            }),
          ),
        ),
        Positioned(
          top: -30, // Adjust the position to overlap the navigation bar
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                // Handle SOS button press
              },
              backgroundColor: Colors.transparent, // Transparent to show the gradient
              elevation: 0, // Remove elevation to use the container's shadow
              child: Text(
                'SOS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}