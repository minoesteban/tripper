import 'dart:convert';
import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/dto/trip_dto.dart';
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
  @JsonKey(name: 'from_date')
    and "legs", where each leg has "title", an "image_url", "from_date" and "to_date" dates in ISO 8601 valid format, "places" and "activities".
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

const _testTripResponse = '''{
   "trip":{
      "name":"Springtime in Paris",
      "image_url":"https://images.unsplash.com/photo-1532822223894-1c493aa065c8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
      "legs":[
         {
            "title":"Arrival in Paris",
            "image_url":"https://images.unsplash.com/photo-1521209429201-35e0b0ef80b7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            "from_date":"2023-03-21",
            "to_date":"2023-03-23",
            "places":[
               "Eiffel Tower",
               "Louvre Museum",
               "Notre Dame Cathedral"
            ],
            "activities":[
               "Take a romantic boat trip down the Seine River",
               "Visit the iconic Eiffel Tower and enjoy the stunning views of the city",
               "Explore the world-renowned Louvre Museum and see masterpieces like the Mona Lisa",
               "Admire the intricate Gothic architecture of Notre Dame Cathedral"
            ]
         },
         {
            "title":"Exploring the Heart of Paris",
            "image_url":"https://images.unsplash.com/photo-1493628284476-c3965a47e6d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            "from_date":"2023-03-24",
            "to_date":"2023-04-05",
            "places":[
               "Palace of Versailles",
               "Sacré-Cœur Basilica",
               "Musée d'Orsay"
            ],
            "activities":[
               "Take a day trip to the magnificent Palace of Versailles and immerse yourself in its opulent history",
               "Visit the Sacré-Cœur Basilica and enjoy panoramic views of the city from its steps",
               "Explore the Musée d'Orsay and admire its collection of Impressionist and Post-Impressionist art"
            ]
         },
         {
            "title":"Cultural Delights",
            "image_url":"https://images.unsplash.com/photo-1507207286780-96f8580a1726?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            "from_date":"2023-04-06",
            "to_date":"2023-04-12",
            "places":[
               "Opéra Garnier",
               "Moulin Rouge",
               "Latin Quarter"
            ],
            "activities":[
               "Attend a performance at the world-famous Opéra Garnier and be mesmerized by its stunning architecture",
               "Experience the vibrant energy of the Moulin Rouge and enjoy a spectacular cabaret show",
               "Stroll through the historic Latin Quarter and discover charming bookstores, quaint cafés, and lively bars"
            ]
         },
         {
            "title":"Farewell to Paris",
            "image_url":"https://images.unsplash.com/photo-1493004577994-70c55d55c530?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            "from_date":"2023-04-13",
            "to_date":"2023-04-15",
            "places":[

            ],
            "activities":[
               "Do some last-minute shopping for souvenirs and gifts",
               "Enjoy a leisurely breakfast at a sidewalk café and soak in the Parisian atmosphere",
               "Say farewell to the City of Light and cherish the memories made during your stay"
            ]
         }
      ]
   }
}''';
