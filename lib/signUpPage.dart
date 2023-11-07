// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shark_valley/dtos/signUpRequest.dto.dart';
import 'package:shark_valley/services/signUpService.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  bool passwordsMatch = false;
  bool passwordsCompleteRequirements = false;
  final minimalLength = 10;
  final TextEditingController userName = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  String incorrectPass = 'Password does not meet the requiremets!';
  String notMatchingPass = 'The passwords do not match!';

  /// Checks and sets the scate of the password.
  void passwordIsCorrect(String password) {
    bool containsLowerCase = false;
    bool containsUpperCase = false;
    bool containsSpecial = false;
    bool containsNumerical = false;
    bool acceptableLength = false;
    passwordsCompleteRequirements = false;

    /// Checks if the password matches all the requirements
    if (password.isEmpty) passwordsCompleteRequirements = false;
    if (password.contains(RegExp(r'[A-Z]'))) containsUpperCase = true;
    if (password.contains(RegExp(r'[a-z]'))) containsLowerCase = true;
    if (password.contains(RegExp(r'[-!@#$%^&*(),.?":{}|<>]'))) {
      containsSpecial = true;
    }
    if (password.contains(RegExp(r'[0-9]'))) containsNumerical = true;
    if (password.length >= minimalLength) acceptableLength = true;

    /// If the password passes all the requirements, set the pass to true.
    if (containsNumerical &&
        containsLowerCase &&
        containsUpperCase &&
        containsSpecial &&
        acceptableLength) {
      passwordsCompleteRequirements = true;
    }
  }

  /// Checks if the password and the renetered password match.
  void passwordsDoMatch(String str1, String str2) {
    if (str1.isEmpty || str2.isEmpty) {
      passwordsMatch = false;
    } else if (str1.compareTo(str2) == 0) {
      passwordsMatch = true;
    } else {
      passwordsMatch = false;
    }
  }

  /// Prints an error message at the bottom of the screen.
  SnackBar errorMessage(String str) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(str),
      ),
    );
  }

  TextField textField(TextEditingController text, String? hintText) {
    return TextField(
      controller: text,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        hintText: hintText,
        prefixIcon: const Icon(Icons.person),
        prefixIconColor: Colors.black,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  TextField passwordTestField(
      TextEditingController text, String? hintText, String? helperText) {
    return TextField(
      controller: text,
      obscureText: true,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        hintText: hintText,
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(color: Colors.green),
        prefixIcon: const Icon(Icons.password),
        prefixIconColor: Colors.black,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          'Sign Up Page',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              // Header of the page ----------------------------------------
              'Enter Your credentials below',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: textField(firstName, 'First Name'),
                  ),
                  Expanded(
                    child: textField(lastName, 'Last Name'),
                  ),
                ],
              ),
            ),
            Padding(
              // Username --------------------------------------------------
              padding: const EdgeInsets.all(10),
              child: textField(userName, 'Enter username or email here'),
            ),
            Padding(
              // First Password Input -----------------------------------
              padding: const EdgeInsets.all(10),
              child: passwordTestField(
                password1,
                'Enter password here',
                'Password must be at least $minimalLength character long and have at least one of each (A-Z), (a-z), (0-9), and special characters!',
              ),
            ),
            Padding(
              // Second Password Input -----------------------------------
              padding: const EdgeInsets.all(10),
              child: passwordTestField(password2, 'Renter password here', ''),
            ),
            Padding(
              // Submit button here -------------------------------------
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  passwordIsCorrect(password1.text);
                  passwordsDoMatch(password1.text, password2.text);
                  if (!passwordsCompleteRequirements) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(errorMessage(incorrectPass));
                  } else {
                    if (!passwordsMatch) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(errorMessage(notMatchingPass));
                    } else {
                      SignUpRequest signUpRequest = SignUpRequest();
                      signUpRequest.firstName = firstName.text;
                      signUpRequest.lastName = lastName.text;
                      signUpRequest.email = userName.text;
                      signUpRequest.password = password2.text;
                      await signUp(signUpRequest, context);
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 15,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
