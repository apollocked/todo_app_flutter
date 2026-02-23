import 'package:todo_app/models/todo_item.dart';

/// Application constants.
class AppConstants {
  AppConstants._();

  /// App name.
  static const String appName = 'Premium Todo';

  /// Sample todo data for initialization.
  static List<TodoItem> get sampleTodos => [
    TodoItem(
      title: 'Design System',
      description: 'Establish core color palette and typography',
      priority: 3,
      isCompleted: true,
    ),
    TodoItem(
      title: 'Review Mockups',
      description: 'Get feedback from the product team',
      priority: 2,
      isCompleted: false,
    ),
    TodoItem(
      title: 'User Testing',
      description: 'Record sessions with 5 beta users',
      priority: 3,
      isCompleted: false,
    ),
    TodoItem(
      title: 'Bug Bash',
      description: 'Triage and fix reported UI issues',
      priority: 1,
      isCompleted: false,
    ),
  ];
}

/// String constants for UI.
class StringConstants {
  StringConstants._();

  // Page titles
  static const String myTasks = 'My Tasks';
  static const String newTask = 'New Task';

  // Actions
  static const String addTask = 'Add Task';
  static const String taskAdded = 'Task added successfully!';
  static const String taskDeleted = 'Task deleted';
  static const String undo = 'Undo';

  // Empty state
  static const String noTasksFound = 'No tasks found';

  // Form labels
  static const String whatNeedsToBeDone = 'What needs to be done?';
  static const String descriptionOptional = 'Description (optional)';
  static const String priority = 'Priority';
}
