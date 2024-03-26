import 'dart:convert';
import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/dto/trip_dto.dart';
import 'package:tripper/data/chat/exceptions.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/chat/finish_reason.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

const _responseJSONPoints = '''\n
    Expected response must be this JSON structure: {points: [{name: String,description: String,rating: double,
    place_id: String,location: {latitude: double,longitude: double},image_url: String}]} where
    rating is google maps rating, place_id is google maps place_id, and location is google maps location coordinates.
    ''';

const _responseJSONTrip = '''\n
    Expected response must be this JSON structure: {trip: {name: String,image_url: String,legs: [{title: String,
    image_url: String,from_date: String,to_date: String,places: [String],activities: [String]}]}}
    where all dates are in Iso8601 valid format.
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
  Future<TripDTO> getTripRecommendations(PlaceAutocompleteResult place, String duration, String people) async {
    const prompt =
        'Given a place, a trip duration and numbers of people, return a recommendation for a trip that fits the parameters.';

    final json = await _sendChatMessage(
      prompt + _responseJSONTrip,
      message: 'place: ${place.description}, duration: $duration, people: $people',
    );

    // final json = jsonDecode(_testTripResponse) as Map<String, dynamic>;

    return TripDTO.fromJson(json['trip'] as Map<String, dynamic>);
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
