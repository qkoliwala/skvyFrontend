class InitLogResponse {
  bool? isCreated;
  bool isCreator;
  String? error;

  InitLogResponse.fromJson(Map<String, dynamic> json)
      : isCreated = json['isCreated'],
        isCreator = json['isCreator'],
        error = json['error'];
}
