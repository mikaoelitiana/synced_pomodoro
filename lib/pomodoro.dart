import 'package:flutter/material.dart';
import 'package:synced_pomodoro/models/pomodoro.dart';
import 'package:synced_pomodoro/services.dart';

class SyncedPomodoro extends StatelessWidget {
  const SyncedPomodoro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.of(context).pomodorosService.getPomodoroById(1),
      builder: (context, AsyncSnapshot<Pomodoro> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          var countDown = snapshot.data?.getCountDown();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Starting at: ',
              ),
              Text(
                '${snapshot.data?.startingAtTime}',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Ending at: ',
              ),
              Text(
                '${snapshot.data?.endingAtTime}',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text('${countDown?['phase'].toString()}'),
              Text(
                '${countDown?['to'].toString()}',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
