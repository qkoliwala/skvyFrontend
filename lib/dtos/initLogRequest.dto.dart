class InitLogRequest {
  String? time;

  Map<String, dynamic> toJson() => {
        'LogInTime': time,
      };
}
