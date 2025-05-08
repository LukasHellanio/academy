import 'package:flutter/material.dart';

class BottomNavItems {
  static List<BottomNavigationBarItem> get items => const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Managers'),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
  ];
}
