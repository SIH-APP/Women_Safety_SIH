import 'package:flutter/material.dart';
import '../models/navigation_item_model.dart';

class NavItemWidget extends StatelessWidget {
  final NavigationItemModel item;

  NavItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: item.isSelected
          ? BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      )
          : null,
      child: Icon(
        item.icon,
        color: item.isSelected ? Colors.white : Colors.black,
        size: 24,
      ),
    );
  }
}