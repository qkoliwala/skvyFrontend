import 'dtos/patrolLogLast10.dto.dart';

class Vault {
  static String? userId;
  static String? userName;
  static String? email;

  // check for initialized log
  static bool isLogInitialized = false;
  static bool wasLogCreated = false;
  static bool isCreator = false;

  // check timer

  static bool hasStartedPatrol = false;
  static bool hasEndedPatrol = false;

  static const String assetsImagePath = 'assets/images/';

  static const String apiKey = "73f158e8a5d9cdc79db9e667a203eedb";
  // url for testing
  // static const String apiBase = "https://10.0.2.2:7132/api";
  //hosting url
  static const String apiBase = "http://44.204.110.3/api";
  static const String identityPath = '$apiBase/identity/login';
  static const String patrolLogPath = '$apiBase/patrolLog';
  static const String patrolLogLast10Path = '$apiBase/patrolLog/last10';

  static const String initLogPath = '$apiBase/patrolLog/initPatrolLog';
  static const String getInitLogPath = '$apiBase/patrolLog/getInitLog';

  static const String startPatrol = '$apiBase/UserTimer/startTime';
  static const String endPatrol = '$apiBase/UserTimer/endTime';
  static const String signUpPath = '$apiBase/signUp';

  List<PatrolLogResponse>? userPatrolLogs;
  int? userPatrolLogsCount;
  int? patroLogsCount;
}
