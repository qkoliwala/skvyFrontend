import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shark_valley/dtos/signUpRequest.dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../vault.dart';

SnackBar errorMessage(String str, Color color) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(str),
    ),
  );
}

Future signUp(SignUpRequest requestDto, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(Vault.signUpPath),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': Vault.apiKey,
      },
      body: jsonEncode(requestDto.toJson()),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorMessage(
          "New user created!",
          const Color.fromARGB(235, 13, 255, 0),
        ),
      );
      context.go('/logInPage');
      return;
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorMessage(
          "User already exists!",
          const Color.fromRGBO(255, 0, 0, 20),
        ),
      );
    }
  } catch (e) {}
  // If the server did not return a 201 CREATED response,
  // then throw an exception.
  return null;
}
