import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // For making HTTP requests (make sure to add it to your pubspec.yaml)

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/initLogRequest.dto.dart';
import 'package:shark_valley/dtos/loginRequest.dto.dart';
import 'package:shark_valley/dtos/loginResponse.dto.dart';
import 'package:shark_valley/services/initLog.service.dart';
import 'package:shark_valley/services/login.service.dart';
import 'package:shark_valley/vault.dart';

import 'package:intl/intl.dart';

import '../vault.dart';

class LogConfirmation extends StatefulWidget {
  @override
  _LogConfirmation createState() => _LogConfirmation();
}

class _LogConfirmation extends State<LogConfirmation> {
  String answer = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrol Log Confirmation'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false, // hide back arrow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Log Was Succesfully Created!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50), // Add spacing
            ElevatedButton(
              onPressed: () async {
                context.go('/completedFormPage');
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
