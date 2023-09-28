import 'dart:convert';

import 'package:shark_valley/dtos/patrolLogLast10.dto.dart';

import '../dtos/patrolTimeRequest.dto.dart';
import 'package:http/http.dart' as http;

import '../vault.dart';

Future savePatrolLog(PatrolTimeRequest requestDto) async {

  try {
    final response = await http.post(
      Uri.parse(Vault.patrolLogPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
        'clientId':Vault.userId??''
      },
      body: jsonEncode(requestDto.toJson()),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
 return;
    }
  }catch(e){
  }
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  return null;


}

Future<PatrolLogLast10Response> getPatrolLogs() async {


    final response = await http.get(
      Uri.parse(Vault.patrolLogLast10Path),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
        'clientId':Vault.userId??''
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var patrolLogsResponse = PatrolLogLast10Response.fromJson(jsonDecode(response.body));
      return patrolLogsResponse;

    }
 else{
      throw Exception('Failed to load patrol logs');
 }



}