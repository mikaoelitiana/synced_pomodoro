class Pomodoro {
  final int id;
  final String name;
  final String startingAtTime;
  final String endingAtTime;
  int? focusInMinutes = 25;
  int? breakInMinutes = 5;
  int? longBreakInMinutes = 15;
  int? loopsBeforeLongBreak = 4;
  bool? active = true;

  Pomodoro(this.id, this.name, this.startingAtTime, this.endingAtTime,
      {this.focusInMinutes,
      this.breakInMinutes,
      this.longBreakInMinutes,
      this.active,
      this.loopsBeforeLongBreak});
}
