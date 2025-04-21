import 'package:elevenlabs_flutter/elevenlabs_config.dart';
import 'package:elevenlabs_streaming_tts/stream.dart';
import 'package:flutter/material.dart';
import 'package:elevenlabs_flutter/elevenlabs_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TTSScreen(),
      ),
    );
  }
}