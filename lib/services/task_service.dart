import '../models/task.dart';
import 'storage_service.dart';

class TaskService {
  final StorageService _storage;

  TaskService(this._storage);

  Future<List<Task>> getTasks() async {
    return await _storage.getTasks();
  }

  Future<void> addTask(String title, bool isFirstDay) async {
    if (!isFirstDay) {
      throw Exception('Tasks can only be added on Day 1');
    }

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );

    await _storage.saveTask(task);
  }

  Future<void> removeTask(String taskId, bool isFirstDay) async {
    if (!isFirstDay) {
      throw Exception('Tasks can only be removed on Day 1');
    }

    final tasks = await getTasks();
    if (tasks.length <= 2) {
      throw Exception('Must have at least 2 tasks');
    }

    await _storage.deleteTask(taskId);
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final tasks = await getTasks();
    final task = tasks.firstWhere((t) => t.id == taskId);
    
    task.isCompleted = !task.isCompleted;
    await _storage.saveTask(task);
  }

  Future<bool> areAllTasksCompleted() async {
    final tasks = await getTasks();
    if (tasks.isEmpty) return false;
    return tasks.every((task) => task.isCompleted);
  }

  Future<void> resetDailyTasks() async {
    final tasks = await getTasks();
    for (var task in tasks) {
      if (task.isCompleted) {
        task.isCompleted = false;
        await _storage.saveTask(task);
      }
    }
  }

  Future<int> getTaskCount() async {
    final tasks = await getTasks();
    return tasks.length;
  }

  Future<bool> validateMinimumTasks() async {
    final count = await getTaskCount();
    return count >= 2;
  }
}
