import 'package:flutter/material.dart';
import 'package:synced_pomodoro/models/pomodoro.dart';
import 'package:synced_pomodoro/pomodoro.dart';
import 'package:synced_pomodoro/services.dart';

void main() async {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const SyncedPomodoroHomePage(title: 'Synced Pomodoro 🍅⏰'),
    ));
  }
}

class SyncedPomodoroHomePage extends StatefulWidget {
  const SyncedPomodoroHomePage({Key? key, required this.title})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SyncedPomodoroHomePage> createState() => _SyncedPomodoroHomePageState();
}

class _SyncedPomodoroHomePageState extends State<SyncedPomodoroHomePage> {
  Pomodoro? _pomodoro;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SyncedPomodoro(),
      ),
    );
  }
}
