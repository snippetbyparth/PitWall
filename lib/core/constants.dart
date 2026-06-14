class F1Constants {
  static const String openF1BaseUrl = 'https://api.openf1.org/v1';
  static const String ergastBaseUrl = 'https://api.jolpi.ca/ergast/f1';

  static int get currentSeason => DateTime.now().year;
  static const int minSession = 2023;
  static const Duration apiTimeout = Duration(seconds: 10);

  static const Map<String,int> teamColors = {
    'Red Bull Racing': 0xFF3671C6,
    'Mercedes': 0xFF27F4D2,
    'Ferrari': 0xFFE8002D,
    'McLaren': 0xFFFF8000,
    'Aston Martin': 0xFF229971,
    'Alpine': 0xFF0093CC,
    'Williams': 0xFF64C4FF,
    'RB': 0xFF6692FF,
    'Kick Sauber': 0xFF52E252,
    'Haas': 0xFFB6BABD,
  };
}