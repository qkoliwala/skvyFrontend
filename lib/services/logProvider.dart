import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/patrolLog.dart';

final patrolLogProvider = ChangeNotifierProvider<PatrolLog>((ref) {
  return PatrolLog();
});