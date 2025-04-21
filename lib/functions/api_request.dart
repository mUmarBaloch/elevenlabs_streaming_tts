import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'dart:async';
class ElevenLabsStreamAudioSource extends StreamAudioSource {
  final Uri url;
  final Map<String, String> headers;
  final String body;

  ElevenLabsStreamAudioSource({
    required this.url,
    required this.headers,
    required this.body,
  });

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    var request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = body;

    final response = await request.send();

    if (response.statusCode != 200) {

      throw Exception('Failed to stream audio : ${response.stream.first.then((_)=>print(_))}, ${response.statusCode}');
    }

    return StreamAudioResponse(
      sourceLength: null,
      contentLength: null,
      offset: 0,
      stream: response.stream,
      contentType: 'audio/mpeg',
    );
  }
}

// http method , without elevenlabs package
 Future<void> _startStreaming() async {
    final source = ElevenLabsStreamAudioSource(
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