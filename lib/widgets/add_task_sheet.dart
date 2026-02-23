import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/priority_selector.dart';

/// Bottom sheet for adding new tasks.
class AddTaskBottomSheet extends StatefulWidget {
  final Function(String title, String description, int priority) onAdd;

  const AddTaskBottomSheet({super.key, required this.onAdd});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _selectedPriority = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1D2E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandleBar(isDark),
          _buildTitle(isDark),
          const SizedBox(height: 24),
          _buildTitleField(),
          const SizedBox(height: 14),
          _buildDescriptionField(),
          const SizedBox(height: 24),
          PrioritySelector(
            selectedPriority: _selectedPriority,
            onPriorityChanged: (p) => setState(() => _selectedPriority = p),
          ),
          const SizedBox(height: 28),
          AddButton(
            onPressed: () => widget.onAdd(
              _titleController.text,
              _descriptionController.text,
              _selectedPriority,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandleBar(bool isDark) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? Colors.white24 : Colors.black12,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildTitle(bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryGradientStart,
                AppColors.primaryGradientEnd,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.add_task_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'New Task',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      autofocus: true,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: const InputDecoration(
        labelText: 'What needs to be done?',
        prefixIcon: Icon(Icons.task_alt_rounded),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 2,
      decoration: const InputDecoration(
        labelText: 'Description (optional)',
        prefixIcon: Icon(Icons.notes_rounded),
        alignLabelWithHint: true,
      ),
    );
  }
}
