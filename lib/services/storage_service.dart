import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_item.dart';

/// Service for persisting data to local storage.
class StorageService {
  static const String _todosKey = 'todos';
  static const String _themeKey = 'isDarkMode';

  /// Save todos to local storage.
  static Future<void> saveTodos(List<TodoItem> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((t) => _todoToJson(t)).toList();
    await prefs.setString(_todosKey, jsonEncode(jsonList));
  }

  /// Load todos from local storage.
  static Future<List<TodoItem>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_todosKey);
    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => _todoFromJson(json)).toList();
  }

  /// Save theme preference.
  static Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  /// Load theme preference.
  static Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  /// Convert TodoItem to JSON map.
  static Map<String, dynamic> _todoToJson(TodoItem todo) {
    return {
      'title': todo.title,
      'description': todo.description,
      'priority': todo.priority,
      'isCompleted': todo.isCompleted,
    };
  }

  /// Create TodoItem from JSON map.
  static TodoItem _todoFromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as int,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
