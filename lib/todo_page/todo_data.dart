import 'package:todo_app/models/todo_item.dart';

class TodoData {
  static List<TodoItem> get todos {
    return [
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
}
