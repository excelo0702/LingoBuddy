import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingo_buddy/constants/app_labels.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  OtpVerifyScreenState createState() => OtpVerifyScreenState();
}

class OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _otpControllers = List.generate(4, (index) => TextEditingController());
  final _otpFocusNodes = List.generate(4, (index) => FocusNode());
  final _submitButtonFocusNode = FocusNode(); // Add FocusNode for the button

  void _onOtpEntered(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]); // Move to next OTP field
      } else {
        FocusScope.of(context).requestFocus(_submitButtonFocusNode); // Move to Submit Button
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]); // Move back to previous field
    }
  }

  void _submitOtp() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${Labels.authentication.otpSubmittedSuccessMsg} $otp")),
      );
      // TODO: Add OTP verification logic here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Labels.authentication.otpSubmittedErrorMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(height: 20),
                flex: 1,
            ),
            Expanded(
              flex: 7,
              child: Column(
                  children: [
                    Text(
                      Labels.authentication.otpVerifyLabel,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _otpFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: "", // Hides maxLength counter
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(width: 2, color: Colors.blue),
                              ),
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) => _onOtpEntered(value, index),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      focusNode: _submitButtonFocusNode,
                      onPressed: _submitOtp,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(Labels.authentication.verifyOtpBtnText, style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
