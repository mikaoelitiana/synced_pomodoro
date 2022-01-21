import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synced_pomodoro/pomodoro.dart';
import 'package:synced_pomodoro/services.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Synced Pomodoro');
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
      home: SyncedPomodoroMainRoute(
        title: 'Synced Pomodoro 🍅⏰',
        prefs: prefs,
      ),
    ));
  }
}

class SyncedPomodoroMainRoute extends StatefulWidget {
  const SyncedPomodoroMainRoute(
      {Key? key, required this.title, required this.prefs})
      : super(key: key);

  final String title;
  final SharedPreferences prefs;

  @override
  State<SyncedPomodoroMainRoute> createState() =>
      _SyncedPomodoroMainRouteState(prefs);
}

class _SyncedPomodoroMainRouteState extends State<SyncedPomodoroMainRoute> {
  SharedPreferences prefs;

  _SyncedPomodoroMainRouteState(this.prefs);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int pomodoroId = prefs.getInt('pomodoro_id') ?? 1;
    return Scaffold(
      body: SyncedPomodoro(pomodoroId),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PreferencesRoute()),
          );
        },
        tooltip: 'Go to preferences',
        child: const Icon(Icons.settings),
      ),
    );
  }
}

class PreferencesRoute extends StatefulWidget {
  const PreferencesRoute({Key? key}) : super(key: key);

  @override
  State<PreferencesRoute> createState() => _PreferencesRouteState();
}

class _PreferencesRouteState extends State<PreferencesRoute> {
  final _formKey = GlobalKey<FormState>();
  final _pomodoroIdTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pomodoroIdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preferences'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _pomodoroIdTextController,
                  decoration: const InputDecoration(label: Text('Pomodoro ID')),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('pomodoro_id',
                            int.parse(_pomodoroIdTextController.text));
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
