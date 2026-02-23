import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

/// Priority selector widget.
class PrioritySelector extends StatelessWidget {
  final int selectedPriority;
  final ValueChanged<int> onPriorityChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white60 : Colors.black54,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            1,
            2,
            3,
          ].map((p) => _buildPriorityItem(p, isDark)).toList(),
        ),
      ],
    );
  }

  Widget _buildPriorityItem(int priority, bool isDark) {
    final isSelected = selectedPriority == priority;
    final color = AppColors.getPriorityColor(priority);
    final name = AppColors.getPriorityName(priority);
    final icon = AppColors.getPriorityIcon(priority);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () => onPriorityChanged(priority),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withAlpha(30)
                  : (isDark
                        ? Colors.white.withAlpha(10)
                        : Colors.black.withAlpha(6)),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Icon(icon, color: isSelected ? color : Colors.grey, size: 20),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? color : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
