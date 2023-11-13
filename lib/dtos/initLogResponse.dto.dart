class InitLogResponse {
  bool? isCreated;
  bool isCreator;
  bool? hasStartedPatrol;
  bool? hasEndedPatrol;
  String? error;

  InitLogResponse.fromJson(Map<String, dynamic> json)
      : isCreated = json['isCreated'],
        isCreator = json['isCreator'],
        hasStartedPatrol = json['hasStartedPatrol'],
        hasEndedPatrol = json['hasEndedPatrol'],
        error = json['error'];
}
