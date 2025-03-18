class Labels {
  static const Authentication authentication = Authentication();
}

class Authentication {
  const Authentication();
  final String mobileNumberInput = "Mobile Number";
  final String hintMobileNumberText = "000000000";
  final String sendOtpBtnText = "Send OTP";
  final String otpVerifyLabel = "Enter the 4-digit OTP sent to your phone";
  final String verifyOtpBtnText = "Verify OTP";
  final String otpSubmittedSuccessMsg = "OTP Submitted: ";
  final String otpSubmittedErrorMsg = 'Please enter a valid OTP';
}