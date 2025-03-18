import 'dart:math';
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class CurvedLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double boxWidth;
  final double boxHeight;
  final double curveHeight; // Allows control over curve bend

  CurvedLinePainter(
      this.start,
      this.end,
      this.boxWidth,
      this.boxHeight, {
        this.curveHeight = 20, // Default curve height
      });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Adjust start & end to touch the box edge
    Offset adjustedStart = getEdgePoint(start, end);
    Offset adjustedEnd = getEdgePoint(end, start);

    final path = Path();
    path.moveTo(adjustedStart.dx+60, adjustedStart.dy);

    // Control point for the curve
    Offset controlPoint = Offset(
      (adjustedStart.dx + adjustedEnd.dx) / 2 , // Midpoint on X
      adjustedStart.dy - curveHeight, // Move up/down for curve
    );

    // Draw a single quadratic curve
  //  path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, adjustedEnd.dx+60, adjustedEnd.dy+30);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, adjustedEnd.dx-10, adjustedEnd.dy+30);

    canvas.drawPath(path, paint);
  }

  // Calculate edge points of the oval box
  Offset getEdgePoint(Offset boxCenter, Offset target) {
    double dx = target.dx - boxCenter.dx;
    double dy = target.dy - boxCenter.dy;
    double angle = atan2(dy, dx); // Get angle of the line
    double newX = boxCenter.dx + (boxWidth / 2) * cos(angle);
    double newY = boxCenter.dy + (boxHeight / 2) * sin(angle);
    return Offset(newX, newY);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
