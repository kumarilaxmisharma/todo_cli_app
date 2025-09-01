# To-Do List CLI App

## Overview

A simple Command-Line Interface (CLI) app built with Dart for managing your tasks.  
This app supports basic CRUD operations and includes stretch features like search, reminders, timestamps, and exporting tasks to JSON.



## Features

- **Add Tasks:** Create new tasks with optional reminders.
- **View Tasks:** List all tasks in a readable format.
- **Update Tasks:** Mark tasks as complete.
- **Delete Tasks:** Remove tasks by ID.
- **Search Tasks:** Find tasks by keyword.
- **Reminders:** Set a date and time reminder for each task.
- **Timestamps:** Track when tasks are created and updated.
- **Export:** Save all tasks to a formatted JSON file.



## File Formats

### `tasks.csv`
Tasks are stored in `tasks.csv` with the following columns:
```
- id: Unique task ID
- title: Task description
- isDone: Completion status (true/false)
- createdAt: Creation timestamp (ISO format)
- updatedAt: Last update timestamp (ISO format)
- reminderAt: Optional reminder timestamp (ISO format)
```

### `tasks_export.json`
Tasks are exported in pretty-printed JSON for easy sharing or backup.



## How to Run

1. **Clone the repository:**
   ```
   git clone https://github.com/yourusername/todo_cli_app.git
   cd todo_cli_app
   ```

2. **Run the app:**
   ```
   dart run src/main.dart
   ```



## What I Learned

- Practiced Dart basics: loops, conditionals, data structures, file I/O.
- Implemented CRUD logic and user input validation.
- Learned how to format and parse dates for user-friendly display.
- Added stretch features like search, reminders, and export.



## Challenges Faced

- Handling date/time parsing and formatting for reminders.
- Designing a readable file format for tasks.
- Ensuring data persists correctly between app runs.



## Improvements for the Future

- Add notifications for reminders.
- Support editing task titles and reminders.
- Integrate with a database for larger scale.
- Build a REST API backend for remote access.



