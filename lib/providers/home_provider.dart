import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pitwall/services/f1_service.dart';

final f1ServiceProvider = Provider((ref) => F1Service());

final homeDataProvider = FutureProvider((ref) async {
  final service = ref.read(f1ServiceProvider);

  final results = await Future.wait([
    service.getDriverStandings(),
    service.getConstructorStandings(),
    service.getRaceSchedule(),
  ]);
  return {
    'driverStandings': results[0],
    'constructorStandings': results[1],
    'raceSchedule': results[2],
  };
});
