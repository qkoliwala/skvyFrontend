import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shark_valley/dtos/startTimerRequest.dto.dart';
import 'package:shark_valley/dtos/startTimerResponse.dto.dart';
import 'package:shark_valley/dtos/endTimerRequest.dto.dart';
import 'package:shark_valley/dtos/endTimerResponse.dto.dart';

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

      if (startTimerResponse.hasStartedPatrol == true) {
        Vault.hasStartedPatrol = true;
      }

      return startTimerResponse;
    }
  } catch (e) {}
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  throw Exception('Something Went Wrong');
}

Future endTimer(EndTimer endTimer) async {
  try {
    final response = await http.post(
      Uri.parse(Vault.endPatrol),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
        'clientId': Vault.userId ?? ''
      },
      body: jsonEncode(endTimer.toJson()),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var endTimerResponse =
          EndTimerResponse.fromJson(jsonDecode(response.body));

      if (endTimerResponse.hasEndedPatrol == true) {
        Vault.hasEndedPatrol = true;
      }

      return endTimerResponse;
    }
  } catch (e) {}
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  throw Exception('Something Went Wrong');
}
