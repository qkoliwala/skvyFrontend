import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shark_valley/dtos/loginRequest.dto.dart';
import 'package:shark_valley/dtos/loginResponse.dto.dart';

import '../vault.dart';

Future<LoginResponse?> login(LoginRequest requestDto) async {
  try {
    final response = await http.post(
      Uri.parse(Vault.identityPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey
      },
      body: jsonEncode(requestDto.toJson()),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      Vault.userName = loginResponse.userName;
      Vault.userId = loginResponse.id;
      return loginResponse;
    }
  }catch(e){
  }
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
   return null;


}