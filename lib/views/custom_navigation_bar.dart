import 'package:flutter/material.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/nav_item_widget.dart';

class CustomNavigationBar extends StatelessWidget {
  final NavigationViewModel viewModel;

  CustomNavigationBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
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
                    String route = viewModel.getSelectedRoute();
                    Navigator.pushNamed(context, route);
                  },
                  child: NavItemWidget(item: item),
                );
              }),
            ),
          ),
          Positioned(
            top: -35,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle SOS button press
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
          ),
        ],
      ),
    );
  }
}
