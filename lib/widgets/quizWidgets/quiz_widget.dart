import 'package:flutter/material.dart';

/// Abstract base class for all quiz types
abstract class QuizWidget extends StatefulWidget {
  final String question;
  final VoidCallback onContinue;
  final VoidCallback onIncorrect;

  const QuizWidget({required this.question, required this.onContinue, required this.onIncorrect, super.key});
}
