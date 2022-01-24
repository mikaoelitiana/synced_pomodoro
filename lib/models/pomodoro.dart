import 'dart:math';

import 'package:intl/intl.dart';

enum Status {
  running,
  stopped,
}

enum Phase { Focus, Break }

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

  int getNextFocusLoop() {
    DateTime now = DateTime.now();
    int i = 0;
    do {
      i++;
    } while (i < focuses.length - 1 && focuses[i].isBefore(now));
    return i;
  }

  DateTime getNextFocusStart() {
    int i = getNextFocusLoop();
    return focuses[i];
  }

  DateTime getNextBreakStart() {
    DateTime now = DateTime.now();
    int i = 0;
    do {
      i++;
    } while (i < breaks.length - 1 && breaks[i].isBefore(now));
    return breaks[i];
  }

  Map<String, dynamic> getCountDown() {
    DateTime now = DateTime.now();
    DateTime nextFocusStart = getNextFocusStart();
    DateTime nextBreakStart = getNextBreakStart();
    int currentLoop = getNextFocusLoop() - 1;
    int to = nextFocusStart.isBefore(nextBreakStart)
        ? nextFocusStart.difference(now).inSeconds
        : nextBreakStart.difference(now).inSeconds;
    Phase phase =
        nextFocusStart.isBefore(nextBreakStart) ? Phase.Break : Phase.Focus;

    return {'phase': phase, 'to': max(0, to), 'loop': currentLoop};
  }
}
