import 'package:flutter/material.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../widgets/nav_item_widget.dart';

class CustomNavigationBar extends StatelessWidget {
  final NavigationViewModel viewModel;

  CustomNavigationBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
    );
  }
}