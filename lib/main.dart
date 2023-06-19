import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/screens/tasks_screen.dart';
import '/models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Task>('tasks');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}
