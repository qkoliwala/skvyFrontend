class LoginResponse {
  String? id;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        email = json['email'],
        firstName = json['FirstName'],
        lastName = json['LastName'];
}
