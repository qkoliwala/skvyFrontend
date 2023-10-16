class StartTimerResponse {
  bool? hasStartedPatrol;
  String? error;

  StartTimerResponse.fromJson(Map<String, dynamic> json)
      : hasStartedPatrol = json['hasStartedPatrol'],
        error = json['error'];
}
