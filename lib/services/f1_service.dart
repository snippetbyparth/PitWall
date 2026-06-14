import 'package:dio/dio.dart';
import 'package:pitwall/core/constants.dart';

class F1Service {
  final Dio _openF1 = Dio(
    BaseOptions(
      baseUrl: F1Constants.openF1BaseUrl,
      connectTimeout: F1Constants.apiTimeout,
      receiveTimeout: F1Constants.apiTimeout,
    ),
  );
  final Dio _jolpica = Dio(
    BaseOptions(
      baseUrl: F1Constants.ergastBaseUrl,
      connectTimeout: F1Constants.apiTimeout,
      receiveTimeout: F1Constants.apiTimeout,
    ),
  );

  // Get current driver standings
  Future<List> getDriverStandings() async {
    try {
      final response = await _jolpica.get(
        '/${F1Constants.currentSeason}/driverStandings.json',
      );
      return response
          .data['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings'];
    } on DioException catch (e) {
      throw Exception('Failed to fetch driver standing: ${e.message}');
    }
  }

  // Get current constructor standings
  Future<List> getConstructorStandings() async {
    try {
      final response = await _jolpica.get(
        '/${F1Constants.currentSeason}/constructorStandings.json',
      );
      return response
          .data['MRData']['StandingsTable']['StandingsLists'][0]['ConstructorStandings'];
    } on DioException catch (e) {
      throw Exception('Failed to fetch constructor standing: ${e.message}');
    }
  }

  // Get race schedule
  Future<List> getRaceSchedule() async {
    try {
      final response = await _jolpica.get('/${F1Constants.currentSeason}.json');
      return response.data['MRData']['RaceTable']['Races'];
    } on DioException catch (e) {
      throw Exception('Failed to fetch race schedule: ${e.message}');
    }
  }

  // Get latest session
  Future<Map> getLatestSession() async {
    try {
      final response = await _openF1.get('/sessions?session_key=latest');
      final data = response.data as List;
      if (data.isEmpty) throw Exception('No session data available');
      return data.last;
    } on DioException catch (e) {
      throw Exception('Failed to fetch latest session: ${e.message}');
    }
  }

  // Get drivers for a session
  Future<List> getSessionDrivers(int sessionKey) async {
    try {
      final response = await _openF1.get('/drivers?session_key=$sessionKey');
      return response.data as List;
    } on DioException catch (e) {
      throw Exception('Failed to fetch session drivers: ${e.message}');
    }
  }

  // Get stints (tire data)
  Future<List> getStints(int sessionKey) async {
    try {
      final response = await _openF1.get('/stints?session_key=$sessionKey');
      return response.data as List;
    } on DioException catch (e) {
      throw Exception('Failed to fetch stints: ${e.message}');
    }
  }

  // Get pit stops
  Future<List> getPitStops(int sessionKey) async {
    try {
      final response = await _openF1.get('/pit?session_key=$sessionKey');
      return response.data as List;
    } on DioException catch (e) {
      throw Exception('Failed to fetch pit stops: ${e.message}');
    }
  }

  // Get intervals (gaps)
  Future<List> getIntervals(int sessionKey) async {
    try {
      final response = await _openF1.get('/intervals?session_key=$sessionKey');
      return response.data as List;
    } on DioException catch (e) {
      throw Exception('Failed to fetch intervals: ${e.message}');
    }
  }
}
