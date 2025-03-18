import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuizCompleted extends StatefulWidget {
  final VoidCallback onContinue;

  const QuizCompleted({super.key, required this.onContinue});

  @override
  State<QuizCompleted> createState() => _QuizCompletedState();
}

class _QuizCompletedState extends State<QuizCompleted> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late ConfettiController _confettiController;
  bool showContinueButton = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _confettiController = ConfettiController(duration: Duration(seconds: 2));

    _sizeAnimation = Tween<double>(
      begin: 50,
      end: 300, // final size of gift box
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    // Start animation
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _confettiController.play();
        setState(() {
          showContinueButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Confetti effect
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
          numberOfParticles: 30,
        ),

        // Gift animation
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  child: Lottie.asset(
                    'assets/animations/quiz_complete.json',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            if (showContinueButton) ...[
              SizedBox(height: 20),
              GestureDetector(
                onTap: widget.onContinue,
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
          ],
        ),
      ],
    );
  }
}
