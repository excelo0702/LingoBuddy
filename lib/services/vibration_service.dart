import 'package:haptic_feedback/haptic_feedback.dart';

class VibrationService {

  static Future<void> makeVibration(HapticsType type) async {
    await Haptics.vibrate(type); // Wait, vibrate 200ms, wait 100ms, vibrate 300ms
  }
}
