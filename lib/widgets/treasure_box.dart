import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreasureBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Icon(Icons.lock, color: Colors.yellow, size: 50),
    );
  }
}