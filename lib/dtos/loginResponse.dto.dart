class LoginResponse {
  String? id;
  String? userName;
  String? email;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        email = json['email'];
}
