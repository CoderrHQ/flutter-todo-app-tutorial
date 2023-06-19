import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  bool isChecked;

  @HiveField(1)
  final String? id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final DateTime? dateCreated;

  Task({
    required this.id,
    required this.title,
    this.isChecked = false,
    required this.description,
    required this.dateCreated,
  });

  @override
  bool operator ==(covariant Task other) =>
      id == other.id &&
      title == other.title &&
      description == other.description;

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        description,
      ]);
}

final List tasks = [];
