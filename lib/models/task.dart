class Task {
  bool isChecked;
  final String? id;
  final String title;
  final String description;
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

List<Task> tasks = [];
