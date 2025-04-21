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
      throw Exception('Failed to stream audio');
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
