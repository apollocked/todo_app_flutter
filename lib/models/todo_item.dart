import 'package:flutter/foundation.dart';

/// Immutable todo item model with copyWith for state management.
@immutable
class TodoItem {
  final String title;
  final String description;
  final int priority;
  final bool isCompleted;

  const TodoItem({
    required this.title,
    required this.description,
    this.priority = 1,
    this.isCompleted = false,
  });

  /// Creates a copy of this TodoItem with the given fields replaced.
  TodoItem copyWith({
    String? title,
    String? description,
    int? priority,
    bool? isCompleted,
  }) {
    return TodoItem(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          priority == other.priority &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      isCompleted.hashCode;
}
