import 'package:flutter/material.dart';
import 'package:tomatin/pages/article_screen.dart';
import 'package:tomatin/pages/home_page.dart';
import 'package:tomatin/pages/plantcollection_screen.dart';
import 'package:tomatin/pages/profile_screen.dart';

import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(onNavigate: _onItemTapped),
      const PlantCollectionScreen(),
      const ArticleScreen(),
      const ProfileScreen(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/scan');
        },
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ImageIcon(
          AssetImage('assets/scan_square.png'),
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomAppBar(
          color: Colors.grey[850],
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
          ),
          notchMargin: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? Colors.green : Colors.white,
                  size: 40,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.local_florist,
                  color: _selectedIndex == 1 ? Colors.green : Colors.white,
                  size: 35,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Spacing for FAB
              IconButton(
                icon: Icon(
                  Icons.article,
                  color: _selectedIndex == 2 ? Colors.green : Colors.white,
                  size: 35,
                ),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: _selectedIndex == 3 ? Colors.green : Colors.white,
                  size: 35,
                ),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
