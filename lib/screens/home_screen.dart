import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: widget.navigationShell.goBranch,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Персонажи'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Избранное'),
        ],
      ),
    );
  }
}
