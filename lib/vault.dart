import 'dtos/patrolLogLast10.dto.dart';

class Vault {
  static String? userId;
  static String? userName;

<<<<<<< HEAD
  // check for initialized log
  static bool isLogInitialized = false;
  static bool wasLogCreated = false;
  static bool isCreator = false;

  static const String assetsImagePath = 'assets/images/';

  static const String apiKey = "73f158e8a5d9cdc79db9e667a203eedb";
  static const String apiBase = "https://10.0.2.2:7132/api";
  static const String identityPath = '$apiBase/identity/login';
  static const String patrolLogPath = '$apiBase/patrolLog';
  static const String patrolLogLast10Path = '$apiBase/patrolLog/last10';

  static const String initLogPath = '$apiBase/patrolLog/initPatrolLog';
  static const String getInitLogPath = '$apiBase/patrolLog/getInitLog';

=======
  static const String assetsImagePath = 'assets/images/';

  static const String apiKey = "73f158e8a5d9cdc79db9e667a203eedb";
  static const String apiBase = "https://10.0.2.2:7132/api";
  static const String identityPath = '$apiBase/identity';
  static const String patrolLogPath = '$apiBase/patrolLog';
  static const String signUpPath = '$apiBase/signUp';
  static const String patrolLogLast10Path = '$apiBase/patrolLog/last10';

>>>>>>> origin/main
  List<PatrolLogResponse>? userPatrolLogs;
  int? userPatrolLogsCount;
  int? patroLogsCount;
}
