import 'package:flutter/material.dart';
import 'package:synced_pomodoro/models/pomodoro.dart';
import 'package:synced_pomodoro/services.dart';
import 'package:countdown_widget/countdown_widget.dart';

class SyncedPomodoro extends StatelessWidget {
  final int pomodoroId;

  const SyncedPomodoro(
    this.pomodoroId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.of(context).pomodorosService.getPomodoroById(pomodoroId),
      builder: (context, AsyncSnapshot<Pomodoro> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Timer(pomodoro: snapshot.data as Pomodoro);
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Timer extends StatefulWidget {
  const Timer({
    Key? key,
    required this.pomodoro,
  }) : super(key: key);

  final Pomodoro pomodoro;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int _duration = 0;
  int _loop = 0;
  Color _backgroundColor = Colors.white;

  void _setCountDown() {
    setState(() {
      var countDown = widget.pomodoro.getCountDown();
      _duration = countDown['to'];
      _backgroundColor =
          countDown['phase'] == Phase.Break ? Colors.green : Colors.red;
      _loop = countDown['loop'];
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _setCountDown());

    return Container(
      decoration: BoxDecoration(color: _backgroundColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.pomodoro.name} (🔁 $_loop)',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .merge(const TextStyle(color: Colors.white)),
            ),
            CountDownWidget(
              duration: Duration(seconds: _duration),
              builder: (context, duration) {
                return Text(
                  _printDuration(duration),
                  style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200)),
                );
              },
              onFinish: () {
                _setCountDown();
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
