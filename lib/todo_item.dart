class TodoItem {
  String title;
  String description;
  int priority;
  bool isCompleted;

  TodoItem({
    required this.title,
    required this.description,
    this.priority = 0,
    this.isCompleted = false,
  });
}
