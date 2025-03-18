import 'package:flutter/material.dart';
import '../painter/curved_line_painter.dart';

class CurvedConnector extends StatelessWidget {
  final Offset start;
  final Offset end;
  final double boxWidth;
  final double boxHeight;

  const CurvedConnector({
    Key? key,
    required this.start,
    required this.end,
    this.boxWidth = 100,
    this.boxHeight = 60, // Make it more oval
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvedLinePainter(start, end, boxWidth, boxHeight),
    );
  }
}
