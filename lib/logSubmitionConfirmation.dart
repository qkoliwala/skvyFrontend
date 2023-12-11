import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // For making HTTP requests (make sure to add it to your pubspec.yaml)
import 'package:go_router/go_router.dart';

/// Once you have submitted a patrol, the app will throw a confirmation
/// page to ensure that the log has been updated in the backend, but also
/// provide visual feedback to the user that their report has been recorded.
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
