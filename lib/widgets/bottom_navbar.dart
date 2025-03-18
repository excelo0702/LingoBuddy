import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.translate), label: "Language"),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Workout"),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Trophy"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
      ],
    );
  }
}