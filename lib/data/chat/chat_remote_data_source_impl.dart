import 'dart:convert';
import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/exceptions.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/chat/finish_reason.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

const _responseJSONPoints =
    '''\nMain property of the JSON is named "points", and each point has a "name", "description",
    google maps "rating", google maps "place_id", "location" coordinates with "latitude" and "longitude", and an "image_url".
    If not points of interest are found, return an empty list. The response must be a valid, parseable JSON object.
    ''';

const _responseJSONTrip = '''\nMain property of the JSON is named "trip", and the trip has a "name", an "image_url",
    and "legs", where each leg has "title", an "image_url", "from" and "to" dates, "places" and "activities".
    The response must be a valid, parseable JSON object.
    ''';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl(this._gemini);

  final Gemini _gemini;

  @override
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude) async {
    const prompt = 'Given location coordinates, return up to 5 relevant landmarks in a 10km radius.';

    final json = await _sendChatMessage(
      prompt + _responseJSONPoints,
      message: 'latitude: $latitude, longitude: $longitude',
    );

    return PointOfInterestListDTO.fromJson(json);
  }

  @override
  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude) async {
    const prompt = 'Given location coordinates, return up to 5 relevant eating places in a 2km radius.';

    final json = await _sendChatMessage(
      prompt + _responseJSONPoints,
      message: 'latitude: $latitude, longitude: $longitude',
    );

    return PointOfInterestListDTO.fromJson(json);
  }

  @override
  Future<String> getTripRecommendations(PlaceAutocompleteResult place, String duration, String people) async {
    const prompt =
        'Given a place, a trip duration and numbers of people, return a recommendation for a trip that fits the parameters.';

    final json = await _sendChatMessage(
      prompt + _responseJSONTrip,
      message: 'place: ${place.description}, duration: $duration, people: $people',
    );

    return json['trip_recommendation'] as String;
  }

  Future<Map<String, dynamic>> _sendChatMessage(String prompt, {required String message}) async {
    final result = await _gemini.text('$prompt\n$message');

    if (result?.output == null) {
      throw ChatResultEmptyException(
        'Finish Reason ${result?.finishReason}: ${getFinishReasonFromCode(result?.finishReason)}',
      );
    }

    final output = result!.output!;

    log('output $output');

    final rawResult = output.substring(output.indexOf('{'), output.lastIndexOf('}') + 1);

    log('rawResult $rawResult');
    final response = jsonDecode(rawResult) as Map<String, dynamic>;

    return response;
  }
}
