import 'package:intl/intl.dart';

class Pomodoro {
  final int id;
  final String name;
  late DateTime startingAtTime;
  late DateTime endingAtTime;
  int focusInMinutes;
  int breakInMinutes;
  int longBreakInMinutes;
  int loopsBeforeLongBreak;
  bool active = true;
  late List<DateTime> focuses;

  Pomodoro(this.id, this.name, String startingAtTime, String endingAtTime,
      {this.focusInMinutes = 25,
      this.breakInMinutes = 5,
      this.longBreakInMinutes = 15,
      this.active = true,
      this.loopsBeforeLongBreak = 4}) {
    DateTime now = DateTime.now();
    this.startingAtTime = DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(now)}T$startingAtTime');
    this.endingAtTime =
        DateTime.parse('${DateFormat('yyyy-MM-dd').format(now)}T$endingAtTime');

    initFocuses();
  }

  void initFocuses() {
    focuses = [startingAtTime];
    DateTime time = startingAtTime;
    int loop = 0;
    while (endingAtTime.isAfter(time)) {
      time = time.add(Duration(
          minutes: focusInMinutes +
              (++loop % loopsBeforeLongBreak == 0
                  ? longBreakInMinutes
                  : breakInMinutes)));
      focuses.add(time);
    }
  }
}
