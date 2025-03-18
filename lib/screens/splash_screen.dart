import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/screens/welcome_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger navigation after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Lottie.asset(
                'assets/animations/splash_screen_animation.json',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
