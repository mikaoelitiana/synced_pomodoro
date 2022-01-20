import 'dart:io';

import 'package:flutter/material.dart';
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

  runApp(const SyncedPomodoroApp());
}

class SyncedPomodoroApp extends StatelessWidget {
  const SyncedPomodoroApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Services(
        child: MaterialApp(
      title: 'Synced Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SyncedPomodoroHomePage(title: 'Synced Pomodoro 🍅⏰'),
    ));
  }
}

class SyncedPomodoroHomePage extends StatefulWidget {
  const SyncedPomodoroHomePage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<SyncedPomodoroHomePage> createState() => _SyncedPomodoroHomePageState();
}

class _SyncedPomodoroHomePageState extends State<SyncedPomodoroHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SyncedPomodoro();
  }
}
