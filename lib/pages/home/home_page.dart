import 'package:encora_community/pages/dashboard/dashboard_page.dart';
import 'package:encora_community/pages/managers/managers_page.dart';
import 'package:flutter/material.dart';
import 'package:encora_community/widgets/drawer_options.dart';
import 'package:encora_community/widgets/bottom_nav_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    ManagersPage(),
    Center(child: Text('Calendar Page')),
    Center(child: Text('Permissions')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        title: Center(
          child: Icon(Icons.menu_book, color: theme.primaryColor, size: 40),
        ),
        actions: const [SizedBox(width: 50, height: 40)],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          color: theme.primaryColor,
          child: Column(
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Icon(Icons.menu_book, color: Colors.white, size: 80),
              ),
              DrawerOptions(),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNavItems.items,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
