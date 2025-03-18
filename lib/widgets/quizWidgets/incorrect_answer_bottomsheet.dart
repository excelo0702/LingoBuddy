import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:lingo_buddy/services/vibration_service.dart';

import '../../services/audio_service.dart';

class IncorrectAnswerBottomsheet extends StatelessWidget {
  final String questionText;
  final String answerText;
  final VoidCallback onContinue;
  final String incorrectSound = "sounds/incorrect.mp3";

  const IncorrectAnswerBottomsheet({super.key, required this.questionText, required this.answerText, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    AudioService.playSound(incorrectSound);
    VibrationService.makeVibration(HapticsType.error);
    return  Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9), // Dark background like the image

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ First Row: Icon + "Nice! Meaning:"
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.red, size: 24),
              SizedBox(width: 8), // Space between icon and text
              Text(
                "Incorrect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          Text(
            "Correct Answer",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          Text(
            questionText,
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          Text(
            "Meaning",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.red),
          ),
          Text(
            answerText,
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),

          SizedBox(height: 16), // Space before button

          // ✅ Continue Button
          GestureDetector(
            onTap: onContinue,
            child: Container(
              width: double.infinity, // Full width
              padding: EdgeInsets.symmetric(vertical: 16), // Comfortable touch area
              decoration: BoxDecoration(
                color: Colors.red, // Button color
                borderRadius: BorderRadius.circular(12), // Rounded edges
              ),
              child: Center(
                child: Text(
                  "GOT IT",
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
