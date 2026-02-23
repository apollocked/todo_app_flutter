import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/models/todo_filter.dart';
import 'package:todo_app/services/storage_service.dart';

/// Provider for managing todo list state with persistence.
class TodoProvider extends ChangeNotifier {
  List<TodoItem> _todos = [];
  TodoFilter _filter = TodoFilter.all;
  bool _isInitialized = false;

  /// All todos.
  List<TodoItem> get todos => List.unmodifiable(_todos);

  /// Current filter.
  TodoFilter get filter => _filter;

  /// Whether todos are loaded from storage.
  bool get isInitialized => _isInitialized;

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

  /// Load todos from local storage.
  Future<void> loadTodos() async {
    _todos = await StorageService.loadTodos();
    _isInitialized = true;
    notifyListeners();
  }

  /// Set the current filter.
  void setFilter(TodoFilter filter) {
    if (_filter != filter) {
      _filter = filter;
      notifyListeners();
    }
  }

  /// Add a new todo and persist.
  Future<void> addTodo(TodoItem todo) async {
    _todos.add(todo);
    await _saveTodos();
    notifyListeners();
  }

  /// Toggle todo completion status and persist.
  Future<void> toggleTodo(TodoItem item) async {
    final index = _todos.indexOf(item);
    if (index != -1) {
      _todos[index] = item.copyWith(isCompleted: !item.isCompleted);
      await _saveTodos();
      notifyListeners();
    }
  }

  /// Delete a todo and persist.
  Future<void> deleteTodo(TodoItem item) async {
    _todos.remove(item);
    await _saveTodos();
    notifyListeners();
  }

  /// Restore a deleted todo.
  Future<void> restoreTodo(TodoItem item, int? index) async {
    if (index != null && index >= 0 && index <= _todos.length) {
      _todos.insert(index, item);
    } else {
      _todos.add(item);
    }
    await _saveTodos();
    notifyListeners();
  }

  /// Get the index of a todo item.
  int? indexOf(TodoItem item) {
    final index = _todos.indexOf(item);
    return index != -1 ? index : null;
  }

  /// Save todos to storage.
  Future<void> _saveTodos() async {
    await StorageService.saveTodos(_todos);
  }
}
