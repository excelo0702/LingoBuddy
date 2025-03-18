import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop) // Ensure the sound resets after playing
    ..setAudioContext(AudioContext(
      // Configure so it doesn't take audio focus or pause background music
      android: AudioContextAndroid(
        isSpeakerphoneOn: false,
        audioFocus: AndroidAudioFocus.none,
        stayAwake: false,
        contentType: AndroidContentType.sonification,
        usageType: AndroidUsageType.assistanceSonification,
      ),
    ));

  static Future<void> playSound(String assetPath) async {
    try {
      await _player.stop(); // Ensure previous sounds don't block new ones
      await _player.play(AssetSource(assetPath), mode: PlayerMode.lowLatency);
    } catch (e) {
      print("Error playing sound: $e");
    }
  }
}
