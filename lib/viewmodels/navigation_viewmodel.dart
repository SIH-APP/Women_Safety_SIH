import 'package:flutter/material.dart';

import '../models/navigation_item_model.dart';

class NavigationViewModel {
  List<NavigationItemModel> _items = [
    NavigationItemModel(icon: Icons.home, isSelected: true),
    NavigationItemModel(icon: Icons.article, isSelected: false),
    NavigationItemModel(icon: Icons.notifications, isSelected: false),
    NavigationItemModel(icon: Icons.settings, isSelected: false),
  ];

  List<NavigationItemModel> get items => _items;

  void selectItem(int index) {
    for (int i = 0; i < _items.length; i++) {
      _items[i] = NavigationItemModel(icon: _items[i].icon, isSelected: i == index);
    }
  }

  String getSelectedRoute() {
    int selectedIndex = _items.indexWhere((item) => item.isSelected);
    switch (selectedIndex) {
      case 0:
        return '/home';
      case 1:
        return '/articles';
      case 2:
        return '/notifications';
      case 3:
        return '/settings';
      default:
        return '/home';
    }
  }
}
