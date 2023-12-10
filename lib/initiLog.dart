import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // For making HTTP requests (make sure to add it to your pubspec.yaml)

import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/initLogRequest.dto.dart';
import 'package:shark_valley/services/initLog.service.dart';
import 'package:shark_valley/vault.dart';

import 'package:intl/intl.dart';

/// This class initialises the creator of the patrol.
/// There will be two options presented to the user,
/// become the patrol creator or be part of the patrol.
/// Once a member becomes the patrol leader, all the other
/// members will be automatically assigned as members of the
/// patrol and this page will not show up for them when
/// entering the app.
class InitLog extends StatefulWidget {
  @override
  _InitLog createState() => _InitLog();
}

class _InitLog extends State<InitLog> {
  String answer = "";
  bool isLogInitialized = Vault.isLogInitialized;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shark Valley Patrol Log'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false, // hide back arrow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you creating the patrol log?',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50), // Add spacing
            ElevatedButton(
              onPressed: () async {
                InitLogRequest initLogRequest = new InitLogRequest();
                final now = DateTime.now();
                String formatter =
                    DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
                initLogRequest.time = formatter;

                await initLog(initLogRequest);

                setState(() {
                  answer = "Yes";
                });

                context.go('/completedFormPage');
              },
              child: Text('Yes'),
            ),
            SizedBox(height: 10), // Add spacing
            ElevatedButton(
              onPressed: () {
                setState(() {
                  answer = "No";
                });

                context.go('/completedFormPage');
              },
              child: Text('No'),
            ),
            SizedBox(height: 20), // Add spacing
            // Text(
            //   'You selected: $answer',
            //   style: TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'Log Initialization: $isLogInitialized',
            //   style: TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
