import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/vault.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() {
    return _UserInfo();
  }
}

String getEmail() {
  if (Vault.email == null) {
    return "No Email Name Detected";
  } else {
    return Vault.email!;
  }
}

String getFirstName() {
  if (Vault.firstName == null) {
    return "No First Name Detected";
  } else {
    return Vault.firstName!;
  }
}

String getLastName() {
  if (Vault.lastName == null) {
    return "No Last Name Detected";
  } else {
    return Vault.lastName!;
  }
}

class _UserInfo extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/completedFormPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          'User Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // Current User Email ----------------------------------------
              "Email: " + getEmail(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              // Current User First Name ----------------------------------------
              "First Name: " + getFirstName(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              // Current User Last Name ----------------------------------------
              "Last Name: " + getLastName(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
