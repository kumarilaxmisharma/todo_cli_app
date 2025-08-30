// src/main.dart

import 'dart:io';
import 'task.dart';

// In-memory "database" to store tasks
final List<Task> tasks = [];
int _nextId = 1; // To assign unique IDs to tasks

void main() {
  // Main application loop
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
        print('👋 Exiting application. Goodbye!');
        return; // Exit the main function, terminating the program
      default:
        print('❌ Invalid choice, please try again.');
    }
    print('\nPress Enter to continue...');
    stdin.readLineSync(); // Pause until user presses Enter
  }
}

void showMenu() {
  print('\n===== To-Do List Menu =====');
  print('1. Add a new task');
  print('2. View all tasks');
  print('3. Update a task (mark as done)');
  print('4. Delete a task');
  print('5. Exit');
  print('===========================');
  print('Enter your choice: ');
}

// CREATE
void addTask() {
  print('Enter the task title:');
  final title = stdin.readLineSync();

  if (title != null && title.isNotEmpty) {
    final newTask = Task(id: _nextId++, title: title);
    tasks.add(newTask);
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
  if (tasks.length < initialLength) {
    print('✅ Task #$id deleted successfully.');
  } else {
    print('❌ Task with ID #$id not found.');
  }
}