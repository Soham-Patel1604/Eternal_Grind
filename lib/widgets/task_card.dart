import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;
  final bool canDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    this.onDelete,
    this.canDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: AppTextStyles.body.copyWith(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? AppColors.dimWhite : AppColors.offWhite,
          ),
        ),
        trailing: canDelete && onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete, color: AppColors.deepRed),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}
