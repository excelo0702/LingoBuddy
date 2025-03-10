import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../painter/nubbin_painter.dart';
import '../screens/quiz_screen.dart';

class StepSelectionPopup extends StatelessWidget {
  final int index;
  final double xOffset;
  final Offset position;
  final VoidCallback onClose;
  final Size size;


  const StepSelectionPopup({
    Key? key,
    required this.index,
    required this.xOffset,
    required this.position,
    required this.onClose,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned(
            left: xOffset / 2,
            top: position.dy + size.height + 10, // You might need to pass the `position.dy + size.height + 10` as well
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Step ${index + 1}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Prove your proficiency",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            onClose();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QuizScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("REVIEW +5 XP"),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: onClose,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("LEGENDARY +40 XP"),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: xOffset / 2,
                    child: CustomPaint(
                      size: const Size(20, 10),
                      painter: NubbinPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
