import 'dart:convert';
import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/exceptions.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/chat/finish_reason.dart';

const _responseJSONPrompt =
    '''\nMain property of the JSON is named "points", and each point has a "name", "description",
    google maps "rating", google maps "place_id", "location" coordinates with "latitude" and "longitude", and an "image_url".
    If not points of interest are found, return an empty list. The response must be a valid, parseable JSON object.
    ''';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl(this._gemini);

  final Gemini _gemini;

  @override
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude) async {
    const prompt = 'Given location coordinates, return up to 5 relevant landmarks in a 10km radius.';

    final json = await _sendChatMessage(
      prompt + _responseJSONPrompt,
      message: 'latitude: $latitude, longitude: $longitude',
    );

    return PointOfInterestListDTO.fromJson(json);
  }

  @override
  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude) async {
    const prompt = 'Given location coordinates, return up to 5 relevant eating places in a 2km radius.';

    final json = await _sendChatMessage(
      prompt + _responseJSONPrompt,
      message: 'latitude: $latitude, longitude: $longitude',
    );

    return PointOfInterestListDTO.fromJson(json);
  }

  Future<Map<String, dynamic>> _sendChatMessage(String prompt, {required String message}) async {
    final result = await _gemini.text('$prompt\n$message');

    if (result?.output == null) {
      throw ChatResultEmptyException(
        'Finish Reason ${result?.finishReason}: ${getFinishReasonFromCode(result?.finishReason)}',
      );
    }

    final rawResult = result!.output!.replaceAll('```json', '').replaceAll('```JSON', '').replaceAll('```', '');

    log('rawResult $rawResult');
    final response = jsonDecode(rawResult) as Map<String, dynamic>;

    return response;
  }
}
