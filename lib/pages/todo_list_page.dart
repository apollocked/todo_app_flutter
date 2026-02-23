import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_filter.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/add_task_sheet.dart';
import 'package:todo_app/widgets/filter_bar.dart';
import 'package:todo_app/widgets/todo_list_view.dart';
import 'package:todo_app/utils/constants.dart';

/// Main todo list page.
class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(StringConstants.myTasks),
            actions: const [_ThemeToggle()],
          ),
          SliverToBoxAdapter(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, _) {
                return FilterBar(
                  currentFilter: todoProvider.filter,
                  filters: TodoFilter.values,
                  onFilterSelected: (f) =>
                      todoProvider.setFilter(f as TodoFilter),
                );
              },
            ),
          ),
          Consumer<TodoProvider>(
            builder: (context, todoProvider, _) {
              return TodoListView(
                tasks: todoProvider.filteredTodos,
                onToggle: (item) => _toggleTodo(context, item),
                onDelete: (item) => _deleteTodo(context, item),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskSheet(context),
        label: const Text(StringConstants.addTask),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTaskBottomSheet(
        onAdd: (title, description, priority) {
          _addTodo(context, title, description, priority);
        },
      ),
    );
  }

  void _addTodo(
    BuildContext context,
    String title,
    String description,
    int priority,
  ) {
    if (title.isEmpty) return;

    final todoProvider = context.read<TodoProvider>();
    todoProvider.addTodo(
      TodoItem(title: title, description: description, priority: priority),
    );

    Navigator.pop(context);
    _showSnackBar(context, StringConstants.taskAdded);
  }

  void _toggleTodo(BuildContext context, TodoItem item) {
    context.read<TodoProvider>().toggleTodo(item);
  }

  void _deleteTodo(BuildContext context, TodoItem item) {
    final todoProvider = context.read<TodoProvider>();
    final index = todoProvider.indexOf(item);

    todoProvider.deleteTodo(item);

    _showSnackBar(
      context,
      StringConstants.taskDeleted,
      actionLabel: StringConstants.undo,
      onAction: () => todoProvider.restoreTodo(item, index),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String content, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: actionLabel != null
            ? SnackBarAction(label: actionLabel, onPressed: onAction!)
            : null,
      ),
    );
  }
}

/// Theme toggle button widget.
class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
    );
  }
}
