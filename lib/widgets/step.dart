import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final double xOffset;
  final String name;
  final GlobalKey keyWidget;
  const StepWidget({super.key, required this.xOffset, required this.name,required this.keyWidget});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        key: keyWidget,
        margin: EdgeInsets.only(left: xOffset),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
