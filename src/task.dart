// src/task.dart

class Task {
  final int id;
  final String title;
  bool isDone;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? reminderAt;

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.reminderAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  String toString() {
    final reminderStr = reminderAt != null ? ', Reminder: ${reminderAt!.toIso8601String()}' : '';
    return '$id. $title [${isDone ? "Done" : "Pending"}] (Created: ${createdAt.toIso8601String()}, Updated: ${updatedAt.toIso8601String()}$reminderStr)';
  }
}