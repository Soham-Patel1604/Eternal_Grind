import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class DayOneSetupScreen extends StatefulWidget {
  const DayOneSetupScreen({super.key});

  @override
  State<DayOneSetupScreen> createState() => _DayOneSetupScreenState();
}

class _DayOneSetupScreenState extends State<DayOneSetupScreen> {
  final TextEditingController _taskController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    final provider = context.read<AppStateProvider>();
    final title = _taskController.text.trim();

    if (title.isEmpty) {
      setState(() => _errorMessage = 'Task cannot be empty');
      return;
    }

    try {
      await provider.addTask(title);
      _taskController.clear();
      setState(() => _errorMessage = null);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  Future<void> _removeTask(String taskId) async {
    final provider = context.read<AppStateProvider>();
    try {
      await provider.removeTask(taskId);
      setState(() => _errorMessage = null);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  Future<void> _finishSetup() async {
    final provider = context.read<AppStateProvider>();
    try {
      await provider.finishDayOneSetup();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day One', style: AppTextStyles.h2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome message
            Text(
              'ETERNAL GRIND',
              style: AppTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            Text(
              'The path of discipline is harsh. There are no shortcuts, no mercy for the weak.',
              style: AppTextStyles.body.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            Text(
              'Define your daily tasks. You must complete ALL tasks each day to maintain your streak.',
              style: AppTextStyles.body.copyWith(height: 1.6),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Minimum: 2 tasks\nAfter today, tasks are locked for the semester.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.crimson,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Task input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: AppTextStyles.body,
                    decoration: const InputDecoration(
                      hintText: 'Enter task...',
                      hintStyle: TextStyle(color: AppColors.dimWhite),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add, color: AppColors.mutedGold),
                ),
              ],
            ),
            
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.cursedRed,
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Task list
            Consumer<AppStateProvider>(
              builder: (context, provider, _) {
                if (provider.tasks.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        'No tasks yet. Add at least 2 tasks to begin.',
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return Column(
                  children: provider.tasks.map((task) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(task.title, style: AppTextStyles.body),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: AppColors.deepRed),
                          onPressed: () => _removeTask(task.id),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Begin button
            Consumer<AppStateProvider>(
              builder: (context, provider, _) {
                final canBegin = provider.tasks.length >= 2;
                return ElevatedButton(
                  onPressed: canBegin ? _finishSetup : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: canBegin ? AppColors.mutedGold : AppColors.charcoalLight,
                  ),
                  child: Text(
                    'BEGIN THE GRIND',
                    style: AppTextStyles.button.copyWith(
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
