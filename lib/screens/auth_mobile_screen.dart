import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingo_buddy/constants/app_colors.dart';
import 'package:lingo_buddy/constants/font_sizes.dart';
import 'package:lingo_buddy/constants/app_labels.dart';

import '../constants/app_margins.dart';
import 'otp_verify_screen.dart';

class AuthMobileScreen extends StatelessWidget {
  const AuthMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: SizedBox(
                height: 20,
              ),
              flex: 2),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: FontSizes.xxl,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(AppMargins.medium),
                    padding: EdgeInsets.all(AppMargins.medium),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: Labels.authentication.mobileNumberInput,
                        hintText: Labels.authentication.hintMobileNumberText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3.0, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerifyScreen(), // Navigate to MobileScreen
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
                      child: Text(Labels.authentication.sendOtpBtnText, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
          ),
          Expanded(child: SizedBox(height: 20),flex: 7),
        ],
      ),
    );
  }
}
