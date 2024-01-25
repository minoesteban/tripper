import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/exceptions.dart';
import 'package:tripper/domain/chat/finish_reason.dart';

class ChatRemoteDataSource implements ChatDataSource {
  ChatRemoteDataSource() : _gemini = Gemini.instance;

  final Gemini _gemini;

  @override
  Future<String> fetchPointsOfInterest(double latitude, double longitude) async {
    const prompt = '''You are a tourism expert. Return relevant points of
        interest based on the given location coordinates.
        Return a list of max 10 points of interest. In JSON format.
        Main property of the JSON is named points, and each point has a name, description,
        google maps rating, google maps place_id, coordinates, and an image url.
        If not points of interest are found, return an empty list.
        ''';

    return await _sendChatMessage(
      prompt,
      message: 'latitude: $latitude, longitude: $longitude',
    );
  }

  Future<String> _sendChatMessage(String prompt, {required String message}) async {
    final result = await _gemini.chat([
      Content(
        parts: [
          Parts(text: prompt),
        ],
        role: 'system',
      ),
      Content(
        parts: [
          Parts(text: message),
        ],
        role: 'user',
      ),
    ]);

    if (result?.output == null) {
      throw ChatResultEmptyException(
        'Finish Reason ${result?.finishReason}: ${getFinishReasonFromCode(result?.finishReason)}',
      );
    }

    return result!.output!;
  }
}
