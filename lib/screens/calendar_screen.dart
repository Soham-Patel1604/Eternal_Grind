import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../services/firestore_service.dart';
import '../models/task_model.dart';
import '../theme/colors.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime? initialDate;
  const CalendarScreen({super.key, this.initialDate});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate!;
      _focusedDate = widget.initialDate!;
    }
  }

  Map<DateTime, List<Task>> _tasksByDate = {};

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final firestoreService = FirestoreService();
    final user = authProvider.currentUser;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALENDAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: isDark ? AppColors.mutedGold : AppColors.deepRed,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark 
                    ? [AppColors.charcoal, AppColors.pureBlack]
                    : [Colors.grey.shade100, Colors.white],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
                    });
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: isDark ? AppColors.mutedGold : AppColors.deepRed,
                  ),
                ),
                Text(
                  '${_getMonthName(_focusedDate.month)} ${_focusedDate.year}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.offWhite : Colors.grey.shade800,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
                    });
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    color: isDark ? AppColors.mutedGold : AppColors.deepRed,
                  ),
                ),
              ],
            ),
          ),
          
          // Calendar Grid
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: firestoreService.getTasksStream(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: AppColors.cursedRed),
                    ),
                  );
                }
                
                final tasks = snapshot.data ?? [];
                _organizeTasksByDate(tasks);
                
                return Column(
                  children: [
                    // Weekday headers
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
                          return SizedBox(
                            width: 40,
                            child: Text(
                              day,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.dimWhite : Colors.grey.shade600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // Calendar days grid
                    Expanded(
                      child: _buildCalendarGrid(isDark),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Selected date tasks
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.charcoal : Colors.grey.shade100,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.charcoalLight : Colors.grey.shade300,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasks for ${_formatDate(_selectedDate)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.offWhite : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildTasksForSelectedDate(isDark),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop(_selectedDate);
        },
        backgroundColor: isDark ? AppColors.deepRed : AppColors.deepRed,
        foregroundColor: Colors.white,
        label: const Text(
          'SELECT DATE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        icon: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildCalendarGrid(bool isDark) {
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final lastDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 42, // 6 weeks * 7 days
      itemBuilder: (context, index) {
        final date = startDate.add(Duration(days: index));
        final isCurrentMonth = date.month == _focusedDate.month;
        final isSelected = _isSameDay(date, _selectedDate);
        final isToday = _isSameDay(date, DateTime.now());
        final tasksForDate = _tasksByDate[_normalizeDate(date)] ?? [];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected 
                  ? (isDark ? AppColors.deepRed : AppColors.deepRed)
                  : isToday
                      ? (isDark ? AppColors.charcoalLight : Colors.grey.shade300)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrentMonth 
                    ? (isDark ? AppColors.charcoalLight : Colors.grey.shade400)
                    : Colors.transparent,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isCurrentMonth
                              ? (isDark ? AppColors.offWhite : Colors.grey.shade800)
                              : (isDark ? AppColors.dimWhite : Colors.grey.shade400),
                      fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (tasksForDate.isNotEmpty)
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        tasksForDate.length > 3 ? 3 : tasksForDate.length,
                        (index) => Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: tasksForDate[index].isCompleted
                                ? (isDark ? AppColors.mutedGold : Colors.green)
                                : (isDark ? AppColors.deepRed : AppColors.deepRed),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTasksForSelectedDate(bool isDark) {
    final tasksForDate = _tasksByDate[_normalizeDate(_selectedDate)] ?? [];
    
    if (tasksForDate.isEmpty) {
      return Center(
        child: Text(
          'No tasks for this date',
          style: TextStyle(
            color: isDark ? AppColors.dimWhite : Colors.grey.shade600,
          ),
        ),
      );
    }
    
    return ListView.builder(
      itemCount: tasksForDate.length,
      itemBuilder: (context, index) {
        final task = tasksForDate[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Icon(
                task.isCompleted 
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 16,
                color: task.isCompleted
                    ? (isDark ? AppColors.mutedGold : Colors.green)
                    : (isDark ? AppColors.deepRed : AppColors.deepRed),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted
                        ? (isDark ? AppColors.dimWhite : Colors.grey)
                        : (isDark ? AppColors.offWhite : Colors.grey.shade800),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _organizeTasksByDate(List<Task> tasks) {
    _tasksByDate.clear();
    for (final task in tasks) {
      final date = _normalizeDate(task.createdAt);
      if (_tasksByDate[date] == null) {
        _tasksByDate[date] = [];
      }
      _tasksByDate[date]!.add(task);
    }
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }
}
