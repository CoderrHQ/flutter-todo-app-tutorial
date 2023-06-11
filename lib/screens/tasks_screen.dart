import 'package:flutter/material.dart';

import '/models/task.dart';
import '/utils/utils.dart';
import '/widgets/task_list_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskListTile(
            task: task,
            onDelete: () {
              tasks.removeWhere((element) => element.id == task.id);
              setState(() {});
            },
            onEdit: () async {
              final newTask = await openAddTaskDialog(
                context: context,
                task: task,
              );
              if (newTask != null) {
                tasks.removeWhere((element) => element.id == newTask.id);
                tasks.insert(0, newTask);
              }
              setState(() {});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await openAddTaskDialog(context: context);
          if (task != null) {
            tasks.add(task);
          }
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
