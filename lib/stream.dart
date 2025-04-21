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
  final player = AudioPlayer();
late ElevenLabsStreamAudioSource source ;
  Future<void> _startStreaming() async {
    source = ElevenLabsStreamAudioSource(
      url: Uri.parse(
          'https://api.elevenlabs.io/v1/text-to-speech/CwhRBWXzGAHq8TQ4Fs17/stream'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'audio/mpeg',
        'xi-api-key': dotenv.env['ELEVENLABS_API_KEY']!,
      },
      body: '{"text":"Hello World, this is a test of streaming API , lets see does it works or not"}',
    );

  }

  @override
  void initState() {
    super.initState();
    _startStreaming();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(child: ElevatedButton(
  onPressed: () async {
    final player = AudioPlayer();
   
    try {
      await player.setAudioSource(source);
      await player.play();
    } catch (e) {
      print('Error: $e');
    }
  },
  child: Text('Play TTS'),
)
,);
  }
}
