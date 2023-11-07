class SignUpRequest {
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'FirstName': firstName,
        'LastName': lastName,
      };
}
