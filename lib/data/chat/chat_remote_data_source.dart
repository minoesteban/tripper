import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/exceptions.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/chat/finish_reason.dart';
import 'package:tripper/utils/platform.dart';

class ChatRemoteDataSource implements ChatDataSource {
  ChatRemoteDataSource(this.packageInfo) {
    init();
  }

  final PackageInfo packageInfo;

  Gemini get _gemini => Gemini.instance;

  void init() {
    Gemini.init(
      enableDebugging: true,
      apiKey: _getGeminiAPIKey(),
      headers: {
        if (isIOS) 'X-Ios-Bundle-Identifier': packageInfo.packageName,
        if (isAndroid) 'X-Android-Package': packageInfo.packageName,
        if (isAndroid) 'X-Android-Cert': packageInfo.buildSignature,
      },
    );
  }

  @override
  Future<PointOfInterestListDTO> fetchPointsOfInterest(double latitude, double longitude) async {
    const prompt = '''Given location coordinates, return up to 10 relevant points of interest.
    Main property of the JSON is named "points", and each point has a "name", "description",
    google maps "rating", google maps "place_id", "location" coordinates with "latitude" and "longitude", and an "image_url".
    If not points of interest are found, return an empty list. The response must be a valid, parseable JSON object.
    ''';

    final json = await _sendChatMessage(
      prompt,
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

String _getGeminiAPIKey() {
  if (kIsWeb) {
    return FlutterConfig.get('GEMINI_API_KEY_WEB') as String;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    return FlutterConfig.get('GEMINI_API_KEY_ANDROID') as String;
  }

  return FlutterConfig.get('GEMINI_API_KEY_IOS') as String;
}
