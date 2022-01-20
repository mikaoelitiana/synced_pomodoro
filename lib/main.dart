import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synced_pomodoro/pomodoro.dart';
import 'package:synced_pomodoro/services.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(600, 400));
    setWindowMaxSize(Size.infinite);
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(SyncedPomodoroApp(prefs: prefs));
}

class SyncedPomodoroApp extends StatelessWidget {
  const SyncedPomodoroApp({Key? key, required this.prefs}) : super(key: key);
  final SharedPreferences prefs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Services(
        child: MaterialApp(
      title: 'Synced Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SyncedPomodoroHomePage(
        title: 'Synced Pomodoro 🍅⏰',
        prefs: prefs,
      ),
    ));
  }
}

class SyncedPomodoroHomePage extends StatefulWidget {
  const SyncedPomodoroHomePage(
      {Key? key, required this.title, required this.prefs})
      : super(key: key);

  final String title;
  final SharedPreferences prefs;

  @override
  State<SyncedPomodoroHomePage> createState() =>
      _SyncedPomodoroHomePageState(prefs);
}

class _SyncedPomodoroHomePageState extends State<SyncedPomodoroHomePage> {
  SharedPreferences prefs;

  _SyncedPomodoroHomePageState(this.prefs);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int pomodoroId = prefs.getInt('pomodoro_id') ?? 1;
    return SyncedPomodoro(pomodoroId);
  }
}
