import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/models/todo_filter.dart';

/// Provider for managing todo list state.
class TodoProvider extends ChangeNotifier {
  List<TodoItem> _todos = [];
  TodoFilter _filter = TodoFilter.all;

  /// Initialize with sample data.
  void initialize(List<TodoItem> initialTodos) {
    _todos = List.from(initialTodos);
    notifyListeners();
  }

  /// All todos.
  List<TodoItem> get todos => List.unmodifiable(_todos);

  /// Current filter.
  TodoFilter get filter => _filter;

  /// Filtered todos based on current filter.
  List<TodoItem> get filteredTodos {
    switch (_filter) {
      case TodoFilter.active:
        return _todos.where((t) => !t.isCompleted).toList();
      case TodoFilter.completed:
        return _todos.where((t) => t.isCompleted).toList();
      case TodoFilter.all:
        return _todos;
    }
  }

  /// Set the current filter.
  void setFilter(TodoFilter filter) {
    if (_filter != filter) {
      _filter = filter;
      notifyListeners();
    }
  }

  /// Add a new todo.
  void addTodo(TodoItem todo) {
    _todos.add(todo);
    notifyListeners();
  }

  /// Toggle todo completion status.
  void toggleTodo(TodoItem item) {
    final index = _todos.indexOf(item);
    if (index != -1) {
      _todos[index] = item.copyWith(isCompleted: !item.isCompleted);
      notifyListeners();
    }
  }

  /// Delete a todo.
  void deleteTodo(TodoItem item) {
    _todos.remove(item);
    notifyListeners();
  }

  /// Restore a deleted todo.
  void restoreTodo(TodoItem item, int? index) {
    if (index != null && index >= 0 && index <= _todos.length) {
      _todos.insert(index, item);
    } else {
      _todos.add(item);
    }
    notifyListeners();
  }

  /// Get the index of a todo item.
  int? indexOf(TodoItem item) {
    final index = _todos.indexOf(item);
    return index != -1 ? index : null;
  }
}
