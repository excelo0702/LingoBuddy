import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 30,
        child: Icon(Icons.star, color: Colors.white),
      ),
    );
  }
}