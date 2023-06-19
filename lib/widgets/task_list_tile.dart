import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/task.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Text(
                  widget.task.description,
                  style: TextStyle(
                    decoration: widget.task.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: widget.onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                Checkbox(
                  value: widget.task.isChecked,
                  onChanged: (value) {
                    widget.task.isChecked = value!;
                    setState(() {});
                    // Update is checked status in Hive DB
                    Hive.box<Task>('tasks').put(
                      widget.task.id,
                      Task(
                        id: widget.task.id,
                        title: widget.task.title,
                        description: widget.task.description,
                        dateCreated: widget.task.dateCreated,
                        isChecked: widget.task.isChecked,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
