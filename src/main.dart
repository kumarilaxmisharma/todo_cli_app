// src/main.dart

import 'dart:io';
import 'task.dart';
import 'dart:convert';

final String tasksFile = 'tasks.csv';

// In-memory "database" to store tasks
final List<Task> tasks = [];
int _nextId = 1; // To assign unique IDs to tasks

void main() {
  loadTasks();
  while (true) {
    showMenu();
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addTask();
        break;
      case '2':
        viewTasks();
        break;
      case '3':
        updateTask();
        break;
      case '4':
        deleteTask();
        break;
      case '5':
        searchTasks();
        break;
      case '6':
        exportTasksToJson();
        break;
      case '7':
        print('👋 Exiting application. Goodbye!');
        return;
      default:
        print('❌ Invalid choice, please try again.');
    }
    print('\nPress Enter to continue...');
    stdin.readLineSync();
  }
}

void showMenu() {
  print('\n===== To-Do List Menu =====');
  print('1. Add a new task');
  print('2. View all tasks');
  print('3. Update a task (mark as done)');
  print('4. Delete a task');
  print('5. Search Tasks');
  print('6. Export tasks to JSON');
  print('7. Exit');
  print('===========================');
  print('Enter your choice: ');
}

void searchTasks() {
  print('Enter keyword to search (matches title or status):');
  final keyword = stdin.readLineSync()?.trim().toLowerCase();
  if (keyword == null || keyword.isEmpty) {
    print('⚠️ Keyword cannot be empty.');
    return;
  }
  final results = tasks.where((task) {
    final title = task.title.trim().toLowerCase();
    final status = task.isDone ? "done" : "pending";
    return title.contains(keyword) || status.contains(keyword);
  }).toList();

  if (results.isEmpty) {
    print('No tasks found matching "$keyword".');
  } else {
    print('\n--- Search Results ---');
    for (var t in results) {
      print(t);
    }
    print('----------------------');
  }
}

// CREATE
void addTask() {
  print('Enter the task title:');
  final title = stdin.readLineSync();

  DateTime? reminderAt;
  print('Set a reminder? (YYYY-MM-DD HH:MM, or leave blank):');
  final reminderInput = stdin.readLineSync();
  if (reminderInput != null && reminderInput.isNotEmpty) {
    try {
      reminderAt = DateTime.parse(reminderInput.replaceFirst(' ', 'T'));
    } catch (_) {
      print('⚠️ Invalid date format. Reminder not set.');
    }
  }

  if (title != null && title.isNotEmpty) {
    final now = DateTime.now();
    final newTask = Task(
      id: _nextId++,
      title: title,
      createdAt: now,
      updatedAt: now,
      reminderAt: reminderAt,
    );
    tasks.add(newTask);
    saveTasks();
    print('✅ Task added successfully!');
  } else {
    print('⚠️ Task title cannot be empty.');
  }
}

// READ
void viewTasks() {
  if (tasks.isEmpty) {
    print('No tasks yet! Add one to get started.');
    return;
  }
  print('\n--- Your Tasks ---');
  tasks.forEach(print); // Uses the toString() method from the Task class
  print('------------------');
}

// UPDATE
void updateTask() {
  viewTasks();
  if (tasks.isEmpty) return;

  print('Enter the ID of the task to mark as complete:');
  final input = stdin.readLineSync();
  final id = int.tryParse(input ?? '');

  if (id == null) {
    print('❌ Invalid ID.');
    return;
  }

  try {
    final taskToUpdate = tasks.firstWhere((task) => task.id == id);
    taskToUpdate.isDone = true;
    taskToUpdate.updatedAt = DateTime.now();
    saveTasks();
    print('✅ Task #$id marked as complete.');
  } catch (e) {
    print('❌ Task with ID #$id not found.');
  }
}

// DELETE
void deleteTask() {
  viewTasks();
  if (tasks.isEmpty) return;

  print('Enter the ID of the task to delete:');
  final input = stdin.readLineSync();
  final id = int.tryParse(input ?? '');

  if (id == null) {
    print('❌ Invalid ID.');
    return;
  }

  final initialLength = tasks.length;
  tasks.removeWhere((task) => task.id == id);
  saveTasks();
  if (tasks.length < initialLength) {
    print('✅ Task #$id deleted successfully.');
  } else {
    print('❌ Task with ID #$id not found.');
  }
}

// Save tasks to file
void saveTasks() {
  final file = File(tasksFile);
  final lines = <String>[];
  // CSV header
  lines.add('id,title,isDone,createdAt,updatedAt,reminderAt');
  for (var t in tasks) {
    lines.add(
      '${t.id},"${t.title.replaceAll('"', '""')}",${t.isDone},${t.createdAt.toIso8601String()},${t.updatedAt.toIso8601String()},${t.reminderAt?.toIso8601String() ?? ''}'
    );
  }
  file.writeAsStringSync(lines.join('\n'));
}



// Load tasks from file
void loadTasks() {
  final file = File(tasksFile);
  if (!file.existsSync()) return;
  final lines = file.readAsLinesSync();
  tasks.clear();
  if (lines.isEmpty) return;
  for (var i = 1; i < lines.length; i++) { // Skip header
    final parts = _parseCsvLine(lines[i]);
    if (parts.length < 6) continue;
    final id = int.tryParse(parts[0]);
    final title = parts[1];
    final isDone = parts[2] == 'true';
    final createdAt = DateTime.tryParse(parts[3]);
    final updatedAt = DateTime.tryParse(parts[4]);
    final reminderAt = parts[5].isNotEmpty ? DateTime.tryParse(parts[5]) : null;
    if (id != null && createdAt != null && updatedAt != null) {
      tasks.add(Task(
        id: id,
        title: title,
        isDone: isDone,
        createdAt: createdAt,
        updatedAt: updatedAt,
        reminderAt: reminderAt,
      ));
      if (id >= _nextId) _nextId = id + 1;
    }
  }
}

// Helper to parse CSV line (handles quoted fields)
List<String> _parseCsvLine(String line) {
  final regex = RegExp(r'"([^"]*)"|([^,]+)');
  return regex.allMatches(line).map((m) => m.group(1) ?? m.group(2) ?? '').toList();
}

void exportTasksToJson() {
  final file = File('tasks_export.json');
  final jsonList = tasks.map((t) => {
    'id': t.id,
    'title': t.title,
    'isDone': t.isDone,
    'createdAt': t.createdAt.toIso8601String(),
    'updatedAt': t.updatedAt.toIso8601String(),
    'reminderAt': t.reminderAt?.toIso8601String() ?? ''
  }).toList();
  final encoder = JsonEncoder.withIndent('  ');
  file.writeAsStringSync(encoder.convert(jsonList));
  print('✅ Tasks exported to tasks_export.json');
}