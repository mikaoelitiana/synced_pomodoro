import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';
import 'package:synced_pomodoro/services/pomodoro.dart';

class Services extends InheritedWidget {
  final PomodorosService pomodorosService;

  Services._({
    required this.pomodorosService,
    required Widget child,
  }) : super(child: child);

  factory Services({required Widget child}) {
    final client = SupabaseClient('https://yhogmhunpfaxhswbeify.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJvbGUiOiJhbm9uIiwiaWF0IjoxNjQyNjAzMDM2LCJleHAiOjE5NTgxNzkwMzZ9.kF5jOV1QJRuQHjY8b4CBcfK0sAw3QIJVe1Kw0irOxfw');
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
