import 'dart:ffi';

import 'package:intl/intl.dart';

enum Status {
  running,
  stopped,
}

enum Phase { _focus, _break }

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
  late List<DateTime> breaks;

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
    breaks = [];
    int loop = 0;
    while (endingAtTime.isAfter(focuses[loop])) {
      focuses.add(focuses[loop].add(Duration(
          minutes: focusInMinutes +
              ((loop + 1) % loopsBeforeLongBreak == 0
                  ? longBreakInMinutes
                  : breakInMinutes))));
      breaks.add(focuses[loop].add(Duration(minutes: focusInMinutes)));
      loop++;
    }
    breaks.add(endingAtTime);
  }

  Status getCurrentStatus() {
    DateTime now = DateTime.now();
    if (startingAtTime.isBefore(now) && startingAtTime.isBefore(now)) {
      return Status.running;
    }
    return Status.stopped;
  }

  DateTime getNextFocusStart() {
    DateTime now = DateTime.now();
    int i = 0;
    while (i <= focuses.length && focuses[i].isBefore(now)) {
      i++;
    }
    return focuses[i];
  }

  DateTime getNextBreakStart() {
    DateTime now = DateTime.now();
    int i = 0;
    while (i <= breaks.length && breaks[i].isBefore(now)) {
      i++;
    }
    return breaks[i];
  }

  Map<String, dynamic> getCountDown() {
    DateTime nextFocusStart = getNextFocusStart();
    DateTime nextBreakStart = getNextBreakStart();
    DateTime to = nextFocusStart.isBefore(nextBreakStart)
        ? nextFocusStart
        : nextBreakStart;
    Phase phase =
        nextFocusStart.isBefore(nextBreakStart) ? Phase._focus : Phase._break;

    return {'phase': phase, 'to': to};
  }
}
