import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_filter.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/add_task_sheet.dart';
import 'package:todo_app/widgets/filter_bar.dart';
import 'package:todo_app/widgets/header_section.dart';
import 'package:todo_app/widgets/todo_list_view.dart';

/// Main todo list page.
class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const HeaderSection(),
          _buildFilterBar(context),
          _buildTodoList(context),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          return FilterBar(
            currentFilter: todoProvider.filter,
            filters: TodoFilter.values,
            onFilterSelected: (f) => todoProvider.setFilter(f as TodoFilter),
          );
        },
      ),
    );
  }

  Widget _buildTodoList(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, _) {
        return TodoListView(
          tasks: todoProvider.filteredTodos,
          onToggle: (item) => _toggleTodo(context, item),
          onDelete: (item) => _deleteTodo(context, item),
        );
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showAddTaskSheet(context),
      icon: const Icon(Icons.add_rounded, size: 22),
      label: const Text(
        StringConstants.addTask,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      elevation: 6,
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
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: AppColors.primaryGradientEnd,
                onPressed: onAction!,
              )
            : null,
      ),
    );
  }
}
