import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/services/audio_service.dart';

class CorrectAnswerBottomsheet extends StatelessWidget {
  final String feedbackText;
  final VoidCallback onContinue;
  const CorrectAnswerBottomsheet({super.key, required this.feedbackText, required this.onContinue});
  final String correctSound = "sounds/correct.mp3";

  @override
  Widget build(BuildContext context) {
    AudioService.playSound(correctSound);
    return  Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  "Nice! Meaning:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),

            SizedBox(height: 4), // Small spacing

            // ✅ Second Line: Explanation Text
            Text(
              "He's a cool teacher!", // Example text
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),

            SizedBox(height: 16), // Space before button

            // ✅ Continue Button
            GestureDetector(
              onTap: onContinue,
              child: Container(
                width: double.infinity, // Full width
                padding: EdgeInsets.symmetric(vertical: 16), // Comfortable touch area
                decoration: BoxDecoration(
                  color: Colors.green, // Button color
                  borderRadius: BorderRadius.circular(12), // Rounded edges
                ),
                child: Center(
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
