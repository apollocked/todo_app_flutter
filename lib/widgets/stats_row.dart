import 'package:flutter/material.dart';
import 'package:todo_app/providers/todo_provider.dart';

/// Statistics row showing task counts and progress.
class StatsRow extends StatelessWidget {
  final TodoProvider provider;
  final bool isDark;

  const StatsRow({super.key, required this.provider, required this.isDark});

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
            StatChip(label: 'Total', value: total, isDark: isDark),
            const SizedBox(width: 10),
            StatChip(
              label: 'Active',
              value: active,
              isDark: isDark,
              color: const Color.fromARGB(255, 255, 239, 12),
            ),
            const SizedBox(width: 10),
            StatChip(
              label: 'Done',
              value: completed,
              isDark: isDark,
              color: const Color.fromARGB(255, 0, 255, 55),
            ),
          ],
        ),
        if (total > 0) ...[
          const SizedBox(height: 14),
          _buildProgressBar(progress, isDark),
        ],
      ],
    );
  }

  Widget _buildProgressBar(double progress, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}

/// Individual statistics chip.
class StatChip extends StatelessWidget {
  final String label;
  final int value;
  final bool isDark;
  final Color color;

  const StatChip({
    super.key,
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
