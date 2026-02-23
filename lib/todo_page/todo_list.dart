import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_page/todo_data.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/todo_list_view.dart';
import 'package:todo_app/widgets/filter_bar.dart';
import 'package:todo_app/widgets/add_task_sheet.dart';
import 'package:todo_app/providers/theme_provider.dart';

enum TodoFilter { all, active, completed }

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> _todos = [];
  TodoFilter _filter = TodoFilter.all;

  @override
  void initState() {
    super.initState();
    _todos = List.from(TodoData.todos);
  }

  List<TodoItem> get _filteredTodos {
    switch (_filter) {
      case TodoFilter.active:
        return _todos.where((t) => !t.isCompleted).toList();
      case TodoFilter.completed:
        return _todos.where((t) => t.isCompleted).toList();
      case TodoFilter.all:
        return _todos;
    }
  }

  void _addTodo(String title, String description, int priority) {
    if (title.isEmpty) return;
    setState(
      () => _todos.add(
        TodoItem(title: title, description: description, priority: priority),
      ),
    );
    Navigator.pop(context);
    _showSnackBar('Task added successfully!');
  }

  void _toggleTodo(TodoItem item) {
    final index = _todos.indexOf(item);
    if (index != -1) {
      setState(() {
        _todos[index] = item.copyWith(isCompleted: !item.isCompleted);
      });
    }
  }

  void _deleteTodo(TodoItem item) {
    setState(() => _todos.remove(item));
    _showSnackBar(
      'Task deleted',
      actionLabel: 'Undo',
      onAction: () => setState(() => _todos.add(item)),
    );
  }

  void _showSnackBar(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('My Tasks'),
            actions: [_ThemeToggle()],
          ),
          SliverToBoxAdapter(
            child: FilterBar(
              currentFilter: _filter,
              filters: TodoFilter.values,
              onFilterSelected: (f) =>
                  setState(() => _filter = f as TodoFilter),
            ),
          ),
          TodoListView(
            tasks: _filteredTodos,
            onToggle: _toggleTodo,
            onDelete: _deleteTodo,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => AddTaskBottomSheet(onAdd: _addTodo),
        ),
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
    );
  }
}
