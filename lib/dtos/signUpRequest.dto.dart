class SignUpRequest {
  String? email;
  String? password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
