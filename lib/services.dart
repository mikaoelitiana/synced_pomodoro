import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';
import 'package:synced_pomodoro/services/pomodoro.dart';

class Services extends InheritedWidget {
  final PomodorosService pomodorosService;

  const Services._({
    required this.pomodorosService,
    required Widget child,
  }) : super(child: child);

  factory Services({required Widget child}) {
    final client = SupabaseClient('https://ykzdagzovjznuvucvhgb.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJvbGUiOiJhbm9uIiwiaWF0IjoxNjQzMjEzNTI3LCJleHAiOjE5NTg3ODk1Mjd9.J_in1uH_kJOfyZE6oFYV6kfvphTEUcOG-JiYSbaDxVk');
    final pomodorosService = PomodorosService(client);
    return Services._(pomodorosService: pomodorosService, child: child);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static Services of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>()!;
  }
}
