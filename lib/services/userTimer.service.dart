import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shark_valley/dtos/startTimerRequest.dto.dart';
import 'package:shark_valley/dtos/startTimerResponse.dto.dart';

import '../vault.dart';

Future startTimer(StartTimer startTimer) async {
  try {
    final response = await http.post(
      Uri.parse(Vault.startPatrol),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
        'clientId': Vault.userId ?? ''
      },
      body: jsonEncode(startTimer.toJson()),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var startTimerResponse =
          StartTimerResponse.fromJson(jsonDecode(response.body));

      return startTimerResponse;
    }
  } catch (e) {}
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  throw Exception('Something Went Wrong');
}
