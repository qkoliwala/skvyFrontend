class StartTimer {
  String? email;
  String? time;

  Map<String, dynamic> toJson() => {
        'email': email,
        'StartedPatrolTime': time,
      };
}
