import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shark_valley/dtos/loginRequest.dto.dart';
import 'package:shark_valley/dtos/loginResponse.dto.dart';
import 'package:shark_valley/dtos/initLogResponse.dto.dart';

import '../vault.dart';

Future initLog() async {
  try {
    final response = await http.post(
      Uri.parse(Vault.initLogPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
        'clientId': Vault.userId ?? ''
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var initLogResponse = InitLogResponse.fromJson(jsonDecode(response.body));

      return initLogResponse;
    }
  } catch (e) {}
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  return null;
}

Future<InitLogResponse> getInitLog() async {
  final response = await http.get(
    Uri.parse(Vault.getInitLogPath),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'x-api-key': Vault.apiKey,
      'clientId': Vault.userId ?? ''
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var initLogResponse = InitLogResponse.fromJson(jsonDecode(response.body));

    // means log is already creaetd
    if (initLogResponse.isCreated == true) {
      // so.. log is already created
      Vault.isLogInitialized = true;
      Vault.isCreator = initLogResponse.isCreator;
    }

    return initLogResponse;
  } else {
    throw Exception('Failed to load patrol logs');
  }
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
}
