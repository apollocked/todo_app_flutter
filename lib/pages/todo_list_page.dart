import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_filter.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/add_task_sheet.dart';
import 'package:todo_app/widgets/filter_bar.dart';
import 'package:todo_app/widgets/todo_list_view.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverHeader(context, isDark),
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
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildSliverHeader(BuildContext context, bool isDark) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1A1D2E), const Color(0xFF0D0F1A)]
                : [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello! 👋',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark
                                ? Colors.white60
                                : Colors.white.withAlpha(200),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          StringConstants.myTasks,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    _ThemeToggle(isDark: isDark),
                  ],
                ),
                const SizedBox(height: 24),
                Consumer<TodoProvider>(
                  builder: (context, provider, _) =>
                      _StatsRow(provider: provider, isDark: isDark),
                ),
              ],
            ),
          ),
        ),
      ),
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

class _StatsRow extends StatelessWidget {
  final TodoProvider provider;
  final bool isDark;

  const _StatsRow({required this.provider, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final total = provider.todos.length;
    final completed = provider.todos.where((t) => t.isCompleted).length;
    final active = total - completed;
    final progress = total == 0 ? 0.0 : completed / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _StatChip(label: 'Total', value: total, isDark: isDark),
            const SizedBox(width: 10),
            _StatChip(
              label: 'Active',
              value: active,
              isDark: isDark,
              color: Color.fromARGB(255, 255, 239, 12),
            ),
            const SizedBox(width: 10),
            _StatChip(
              label: 'Done',
              value: completed,
              isDark: isDark,
              color: const Color.fromARGB(255, 0, 255, 55),
            ),
          ],
        ),
        if (total > 0) ...[
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white.withAlpha(50),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(progress * 100).toInt()}% completed',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.white.withAlpha(200),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final bool isDark;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.isDark,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(isDark ? 18 : 30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(40)),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(isDark ? 150 : 200),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  const _ThemeToggle({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(isDark ? 18 : 40),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withAlpha(50)),
        ),
        child: Icon(
          themeProvider.isDarkMode
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
