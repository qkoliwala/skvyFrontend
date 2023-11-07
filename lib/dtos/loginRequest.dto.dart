class LoginRequest {
  String? email;
  String? password;
  String? logInTime;

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'LogInTime': logInTime};
}
