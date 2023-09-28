class LoginResponse{

  String? id;
  String? userName;

  LoginResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'];
}