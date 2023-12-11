import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/dtos/loginRequest.dto.dart';
import 'package:shark_valley/services/initLog.service.dart';
import 'package:shark_valley/services/login.service.dart';
import 'package:shark_valley/vault.dart';
import 'package:intl/intl.dart';

/// This class implements the log in page that allows the
/// user to enter their details and log into the app. The
/// user will be presented with two boxes to enter the email
/// and the password combination, and two buttons, one for
/// confirming your credentials and logging in, and the other
/// called Sign Up, to go and create a new account if the user
/// does not have one.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Toggle the visibility of the password in the log in page.
  void _toggleVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  /// Initialise the password to be non-visible.
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    _usernameController.text = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shark Valley Patrol Log'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: AutofillGroup(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("${Vault.assetsImagePath}logo.png"),
                  ),
                  ...[
                    TextField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'user@email.com',
                        labelText: 'Email',
                      ),
                      autofillHints: [AutofillHints.email],
                    ),
                    TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter password here',
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _toggleVisibility();
                          },
                        ),
                      ),
                      obscureText: !_passwordVisible,
                    ),
                    FilledButton(
                        onPressed: () async {
                          if (_usernameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            LoginRequest loginRequest = LoginRequest();
                            loginRequest.email = _usernameController.text;
                            loginRequest.password = _passwordController.text;

                            final now = DateTime.now();
                            String formatter =
                                DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
                            loginRequest.logInTime = formatter;
                            await login(loginRequest);

                            if (Vault.userId != null) {
                              // add initialized log here
                              await getInitLog();

                              if (Vault.isLogInitialized) {
                                context.go('/completedFormPage');
                              } else
                                context.go('/createLog');
                            } else {
                              var snackbar = SnackBar(
                                content: Text('Incorrect Email or Password'),
                                elevation: 16,
                                backgroundColor: Colors.blueGrey,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                duration: Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          }
                        },
                        child: const Text('Log In')),
                    FilledButton(
                      onPressed: () {
                        context.go('/signUpPage');
                      },
                      child: const Text('Sign Up'),
                    ),
                  ].expand(
                    (widget) => [
                      widget,
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
