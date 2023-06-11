import 'package:flutter/material.dart';

import '/models/task.dart';
import '/widgets/add_task_dialog.dart';

Future<Task?> openAddTaskDialog({
  required BuildContext context,
  Task? task,
}) {
  return showDialog<Task?>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AddTaskDialog(
        task: task,
      );
    },
  );
}
