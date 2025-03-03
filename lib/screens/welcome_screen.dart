import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
              padding: const EdgeInsets.only(top:20.0),
              child: Image.asset(
                "assets/welcome_image.png",
                fit:BoxFit.fitWidth,
              ),

            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.buttonText,
                      ),
                    )
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
