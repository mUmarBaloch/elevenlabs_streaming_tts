import 'package:elevenlabs_flutter/elevenlabs_config.dart';
import 'package:elevenlabs_flutter/elevenlabs_flutter.dart';
import 'package:elevenlabs_flutter/elevenlabs_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio/just_audio.dart';

import 'functions/api_request.dart';

class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  @override
  State<TTSScreen> createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
   late ElevenLabsAPI? _elevenLabsAPI;
   final AudioPlayer _audioPlayer = AudioPlayer();
late ElevenLabsStreamAudioSource source ;
 

  @override
  void initState() {
    final apiKey=dotenv.env['ELEVENLABS_API_KEY']!;
      _elevenLabsAPI = ElevenLabsAPI();
    _elevenLabsAPI?.init(
      config: ElevenLabsConfig(apiKey:apiKey,baseUrl: 'https://api.elevenlabs.io'),
    );
    super.initState();
   
  }

  Future<void> _speak(String text) async {
    try {
      final file = await _elevenLabsAPI?.synthesize(
        TextToSpeechRequest(text: text,voiceId: 'CwhRBWXzGAHq8TQ4Fs17'),
      );
      await _audioPlayer.setFilePath(file!.path);
      _audioPlayer.play();
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Center(child: ElevatedButton(
  onPressed: () async {
  _speak('Hello world, this is a real-time voice stream from Eleven Labs.');
  },
  child: Text('Play TTS'),
)
,);
  }
}
