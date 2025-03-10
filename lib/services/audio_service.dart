import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSound(String assetPath) async {
    await _player.play(AssetSource(assetPath));
  }
}
