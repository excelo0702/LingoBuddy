import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/services/tts_service.dart';
import 'package:lingo_buddy/widgets/quizWidgets/quiz_widget.dart';

import '../../models/quiz_picture_option.dart';
import 'correct_answer_bottomsheet.dart';
import 'incorrect_answer_bottomsheet.dart';

class PictureChoiceQuiz extends QuizWidget {
  final List<QuizOptionModel> options;
  final int correctIndex;

  const PictureChoiceQuiz({
    required String question,
    required this.options,
    required this.correctIndex,
    required VoidCallback onContinue,
    required VoidCallback onIncorrect,
    Key? key,
  }) : super(question: question, onContinue: onContinue, onIncorrect: onIncorrect);

  @override
  _PictureChoiceQuizState createState() => _PictureChoiceQuizState();
}

class _PictureChoiceQuizState extends State<PictureChoiceQuiz> {
  int? selectedIndex;
  bool isAnswered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TtsService.speak(widget.question, language: "te-IN");
  }

  @override
  void didUpdateWidget(covariant PictureChoiceQuiz oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.question != widget.question) {
      TtsService.speak(widget.question, language: "te-IN");  // Speak only when the question changes
    }
  }

  void selectAnswer(int index) {
    if (!isAnswered) {
      setState(() {
        selectedIndex = index;
        isAnswered = true;
      });
    }

    if (index == widget.correctIndex) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) => CorrectAnswerBottomsheet(
          onContinue: () {
            Navigator.of(context).pop(); // Close BottomSheet
            setState(() {
              selectedIndex = null; // Reset selected answer
              isAnswered = false; // Reset answer state
            });
            widget.onContinue();
          },
          feedbackText: "Great job! 🎉",
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) => IncorrectAnswerBottomsheet(
            questionText: widget.question,
            answerText: "Correct Answer",
          onContinue: () {
            Navigator.of(context).pop(); // Close BottomSheet
            setState(() {
              selectedIndex = null; // Reset selected answer
              isAnswered = false; // Reset answer state
            });
            widget.onIncorrect();
          },
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question Text
        Row(
          children: [
            Text(
              widget.question,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.volume_up, color: Colors.white),
              color: Colors.blue,
              onPressed: () {
                TtsService.speak(widget.question, language: "te-IN");
              },
            )
          ],
        ),


        SizedBox(height: 20),

        // Image Grid (Answer Choices)
        Expanded(
          child: LayoutBuilder(
              builder: (context, constraints) {
                double availableHeight = constraints.maxHeight; // Get the available screen height
                double itemSize = availableHeight / 2; // Each item takes half of it
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.options.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2x2 Grid
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: itemSize,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;
                    bool isCorrect = index == widget.correctIndex;
                    bool isWrong = isSelected && !isCorrect;

                    return GestureDetector(
                      onTap: () => selectAnswer(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:  isSelected
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        transform: isAnswered
                            ? (isCorrect
                            ? Matrix4.diagonal3Values(1.01, 1.01, 1) // Correct answer: Enlarge
                            : (isWrong ? Matrix4.diagonal3Values(0.99, 0.99, 1) // Wrong answer: Shrink
                            : Matrix4.identity()))
                            : Matrix4.identity(),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                widget.options[index].imagePath,
                                height: itemSize-10,
                                fit: BoxFit.cover,),
                            )

                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),

        SizedBox(height: 20),

        // Continue Button (only appears after selection)
      ],
    ),

      ],
    );

  }
}
