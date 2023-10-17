class StartTimer {
  String? time;

  Map<String, dynamic> toJson() => {
        'StartedPatrolTime': time,
      };
}
