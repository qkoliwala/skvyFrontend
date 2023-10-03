class InitLogResponse {
  bool? isCreated;
  String? error;

  InitLogResponse.fromJson(Map<String, dynamic> json)
      : isCreated = json['isCreated'],
        error = json['error'];
}
