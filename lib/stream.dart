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

  Future<void> _startStreaming() async {
    final source = ElevenLabsStreamAudioSource(
      url: Uri.parse(
          'https://api.elevenlabs.io/v1/text-to-speech/YOUR_VOICE_ID/stream'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'audio/mpeg',
        'xi-api-key': dotenv.env['ELEVENLABS_API_KEY']!,
      },
      body: '{"text":"Hello World"}',
    );

    try {
      await player.setAudioSource(source);
      await player.play();
    } catch (e) {
      print('Error playing stream: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _startStreaming();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
