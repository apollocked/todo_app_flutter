import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoListView extends StatelessWidget {
  final List<TodoItem> tasks;
  final Function(TodoItem) onToggle;
  final Function(TodoItem) onDelete;

  const TodoListView({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return _buildEmptyState(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = tasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Dismissible(
              key: ObjectKey(item),
              background: _buildDismissBackground(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => onDelete(item),
              child: TodoCard(
                item: item,
                onTap: () => onToggle(item),
                onCheckboxChanged: (_) => onToggle(item),
              ),
            ),
          );
        }, childCount: tasks.length),
      ),
    );
  }

  Widget _buildDismissBackground() => Container(
    decoration: BoxDecoration(
      color: Colors.red.withAlpha(25),
      borderRadius: BorderRadius.circular(16),
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    child: const Icon(Icons.delete_outline, color: Colors.red),
  );

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_rtl,
            size: 80,
            color: colorScheme.outline.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
