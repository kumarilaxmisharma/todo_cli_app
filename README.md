# To-Do List CLI App

A simple Command-Line Interface (CLI) application built with Dart to manage your daily tasks. This project was created as part of a mini-challenge to practice core programming concepts.

## Functionality

This app provides full CRUD (Create, Read, Update, Delete) functionality for managing a to-do list:

* **Create**: Add a new task to your list.
* **Read**: View all the tasks currently on your list with their completion status.
* **Update**: Mark a task as completed.
* **Delete**: Remove a task from your list.

## How to Run the App

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url>
    cd todo-cli-app
    ```

2.  **Ensure you have the Dart SDK installed.** You can find installation instructions on the [official Dart website](https://dart.dev/get-dart).

3.  **Run the application from the terminal:**
    ```bash
    dart run src/main.dart
    ```

## Mini Report

### What I Learned

* **Dart Fundamentals**: This project was a great way to reinforce my understanding of Dart syntax, including loops (`while`), conditionals (`switch`), data structures (`List`), and classes.
* **Handling User Input**: I learned how to read user input from the command line using `dart:io` and `stdin.readLineSync()`, as well as how to handle potential `null` values and parse strings into integers.
* **Application Structure**: I practiced organizing code by separating the data model (`Task` class) from the main application logic, which makes the code cleaner and easier to maintain.
* **Core CRUD Logic**: Implementing the four CRUD operations from scratch solidified my understanding of these fundamental patterns which are essential for any data-driven application.

### Challenges Faced

* **Input Validation**: A primary challenge was handling bad user input. For example, if a user entered text instead of a number for a task ID, the `int.parse()` would throw an error. I solved this by using `int.tryParse()`, which returns `null` on failure, allowing me to handle the error gracefully.
* **State Management**: The list of tasks is stored in memory, which means it resets every time the app closes. This is simple, but it makes the app non-persistent.

### Possible Improvements

If I had more time, I would add the following features (the "Stretch Goals"):

* **Data Persistence**: Save the tasks to a file (like JSON or CSV) so the list is saved even after the application is closed. I would explore using `dart:io` for file I/O or a package like `hive` for a simple local database.
* **More Robust Update**: Allow users to not just mark a task as done, but also to edit the title of the task.
* **Input Validation**: Add more checks, for example, preventing a user from adding a task with an empty title.
* **Search/Filter**: Implement a feature to search for tasks by a keyword.