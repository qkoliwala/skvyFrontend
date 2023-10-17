class EndTimerResponse {
  bool? hasEndedPatrol;
  String? error;

  EndTimerResponse.fromJson(Map<String, dynamic> json)
      : hasEndedPatrol = json['hasEndedPatrol'],
        error = json['error'];
}
