import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandle(),
          Text(
            'New Task',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            _titleController,
            'What needs to be done?',
            Icons.task_alt,
            true,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            _descriptionController,
            'Description (optional)',
            Icons.description_outlined,
            false,
          ),
          const SizedBox(height: 20),
          _buildPrioritySelector(),
          const SizedBox(height: 24),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildHandle() => Center(
    child: Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool autofocus,
  ) => TextField(
    controller: controller,
    autofocus: autofocus,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  Widget _buildPrioritySelector() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Priority', style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(height: 8),
      Row(
        children: [1, 2, 3]
            .map(
              (p) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(AppColors.getPriorityName(p)),
                    selected: _selectedPriority == p,
                    onSelected: (selected) =>
                        setState(() => _selectedPriority = p),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ],
  );

  Widget _buildAddButton() => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: () => widget.onAdd(
        _titleController.text,
        _descriptionController.text,
        _selectedPriority,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Add Task',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
