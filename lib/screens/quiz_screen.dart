import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/screens/progress_screen.dart';
import 'package:lingo_buddy/services/audio_service.dart';
import 'package:lottie/lottie.dart';

import '../models/quiz_picture_option.dart';
import '../widgets/quizWidgets/picture_choice_quiz.dart';
import '../widgets/quizWidgets/quiz_completed.dart';
import '../widgets/quizWidgets/quiz_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  late List<QuizWidget> quizQuestions;
  List<QuizWidget> incorrectQuestions = [];
  bool quizCompleted = false;
  bool showContinueButton = false;

  // Sample questions (In a real app, this could come from an API or database)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizQuestions = [
      PictureChoiceQuiz(
        question: "గ్రీన్ టీ",
        options: [
          QuizOptionModel(imagePath: "assets/water.jpg", label: "water"),
          QuizOptionModel(imagePath: "assets/green_tea.jpg", label: "green tea"),
          QuizOptionModel(imagePath: "assets/sushi.jpg", label: "sushi"),
          QuizOptionModel(imagePath: "assets/rice.jpg", label: "rice"),
        ],
        correctIndex: 1,
        onContinue: () => nextQuestion(isCorrect: true),
        onIncorrect: () => nextQuestion(isCorrect: false),
      ),
      PictureChoiceQuiz(
        question: "బియ్యం",
        options: [
          QuizOptionModel(imagePath: "assets/green_tea.jpg", label: "green tea"),
          QuizOptionModel(imagePath: "assets/sushi.jpg", label: "sushi"),
          QuizOptionModel(imagePath: "assets/rice.jpg", label: "rice"),
          QuizOptionModel(imagePath: "assets/water.jpg", label: "water")
        ],
        correctIndex: 1,
        onContinue: () => nextQuestion(isCorrect: true),
        onIncorrect: () => nextQuestion(isCorrect: false),
      ),
      PictureChoiceQuiz(
        question: "సూషి",
        options: [
          QuizOptionModel(imagePath: "assets/sushi.jpg", label: "sushi"),
          QuizOptionModel(imagePath: "assets/water.jpg", label: "banana"),
          QuizOptionModel(imagePath: "assets/green_tea.jpg", label: "green tea"),
          QuizOptionModel(imagePath: "assets/rice.jpg", label: "rice"),
        ],
        correctIndex: 1,
        onContinue: () => nextQuestion(isCorrect: true),
        onIncorrect: () => nextQuestion(isCorrect: false),
      ),
      PictureChoiceQuiz(
        question: "నీళ్లు",
        options: [
          QuizOptionModel(imagePath: "assets/water.jpg", label: "apple"),
          QuizOptionModel(imagePath: "assets/green_tea.jpg", label: "green tea"),
          QuizOptionModel(imagePath: "assets/sushi.jpg", label: "sushi"),
          QuizOptionModel(imagePath: "assets/rice.jpg", label: "rice"),
        ],
        correctIndex: 1,
        onContinue: () => nextQuestion(isCorrect: true),
        onIncorrect: () => nextQuestion(isCorrect: false),
      ),
    ];
  }

  void nextQuestion({required bool isCorrect}) {
    if (!isCorrect) {
      // Push incorrect question to the end
      incorrectQuestions.add(quizQuestions[currentQuestionIndex]);
    }

    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else if (incorrectQuestions.isNotEmpty) {
      // Restart quiz with incorrect questions
      setState(() {
        quizQuestions = incorrectQuestions;
        incorrectQuestions = [];
        currentQuestionIndex = 0;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
      print("Quiz Completed!");
      AudioService.playSound('sounds/quiz_complete.mp3');
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showContinueButton = true;
        });
      });

      // Optionally, navigate to results screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Match dark theme
      appBar: AppBar(title: Text("Quiz"), backgroundColor: Colors.black),
      body: quizCompleted ?
      QuizCompleted(onContinue: () {
        Navigator.push(
          context,
            MaterialPageRoute(builder: (context) => ProgressScreen()),
          );
        },
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LinearProgressIndicator(value: currentQuestionIndex/quizQuestions.length, backgroundColor: Colors.grey[800], color: Colors.green),
          SizedBox(height: 16),
          Expanded(child:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: quizQuestions[currentQuestionIndex], // Load current quiz question
          ),
          ),
        ],
      ),
    );
  }
}
