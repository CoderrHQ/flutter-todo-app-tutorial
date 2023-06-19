import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context, box, child) {
          // Get list of all tasks
          final tasks = box.values;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              // get current task
              final task = tasks.elementAt(index);
              return TaskListTile(
                task: task,
                onDelete: () {
                  Hive.box<Task>('tasks').delete(task.id);
                },
                onEdit: () async {
                  final newTask = await openAddTaskDialog(
                    context: context,
                    task: task,
                  );
                  if (newTask != null) {
                    // update a task in "tasks" box
                    Hive.box<Task>('tasks').put(task.id, newTask);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await openAddTaskDialog(context: context);
          if (task != null) {
            // Add task to "tasks" box
            Hive.box<Task>('tasks').put(task.id, task);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
