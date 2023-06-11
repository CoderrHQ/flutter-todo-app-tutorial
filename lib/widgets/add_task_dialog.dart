import 'package:flutter/material.dart';

import '/models/task.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    Key? key,
    this.task,
  }) : super(key: key);

  final Task? task;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
            minLines: 1,
            maxLines: 5,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Task task = Task(
              id: DateTime.now().toString(),
              title: _titleController.text,
              description: _descriptionController.text,
              dateCreated: DateTime.now(),
            );
            if (widget.task != null) {
              task = Task(
                id: widget.task!.id,
                title: _titleController.text,
                description: _descriptionController.text,
                dateCreated: widget.task!.dateCreated,
                isChecked: widget.task!.isChecked,
              );
            }
            Navigator.of(context).pop(task);
          },
          child: const Text('Add Task'),
        ),
      ],
    );
  }
}
