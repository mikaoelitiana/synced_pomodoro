import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synced_pomodoro/models/pomodoro.dart';

class PomodorosService {
  static const pomodoros = 'pomodoros';

  final SupabaseClient _client;

  PomodorosService(this._client);

  Future<Pomodoro> getPomodoroById(int id) async {
    final response =
        await _client.from(pomodoros).select().eq('id', id).execute();
    if (response.error == null) {
      return toPomodoro(response.data[0]);
    }
    return Pomodoro(0, 'Default pomodoro', '09:00:00+02', '18:00:00+02');
  }

  Pomodoro toPomodoro(Map<String, dynamic> result) {
    return Pomodoro(
      result['id'],
      result['name'],
      result['starting_at'],
      result['ending_at'],
      focusInMinutes: result['focus'],
      breakInMinutes: result['break'],
      longBreakInMinutes: result['long_break'],
    );
  }
}
