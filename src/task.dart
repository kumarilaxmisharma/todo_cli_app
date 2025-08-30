// src/task.dart

class Task {
  String title;
  bool isDone;
  final int id; // Unique ID for each task

  // Constructor
  Task({required this.id, required this.title, this.isDone = false});

  // A method to easily display the task
  @override
  String toString() {
    return '$id. [${isDone ? 'x' : ' '}] $title';
  }
}