import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/user_profile.dart';
import '../models/streak_data.dart';
import '../models/cursed_mark.dart';
import '../models/relief_day.dart';

class StorageService {
  static const String _userProfileBox = 'user_profile';
  static const String _tasksBox = 'tasks';
  static const String _profileKey = 'profile';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register type adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(StreakDataAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CursedMarkAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ReliefDayAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(TaskAdapter());
    }
    
    await Hive.openBox(_userProfileBox);
    await Hive.openBox(_tasksBox);
  }

  // User Profile operations
  Future<UserProfile?> getUserProfile() async {
    final box = Hive.box(_userProfileBox);
    final data = box.get(_profileKey);
    if (data == null) return null;
    return UserProfile.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    final box = Hive.box(_userProfileBox);
    await box.put(_profileKey, profile.toJson());
  }

  Future<void> deleteUserProfile() async {
    final box = Hive.box(_userProfileBox);
    await box.delete(_profileKey);
  }

  // Task operations
  Future<List<Task>> getTasks() async {
    final box = Hive.box(_tasksBox);
    final tasks = <Task>[];
    for (var key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        tasks.add(Task.fromJson(Map<String, dynamic>.from(data)));
      }
    }
    return tasks;
  }

  Future<void> saveTask(Task task) async {
    final box = Hive.box(_tasksBox);
    await box.put(task.id, task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    final box = Hive.box(_tasksBox);
    await box.delete(taskId);
  }

  Future<void> deleteAllTasks() async {
    final box = Hive.box(_tasksBox);
    await box.clear();
  }

  Future<void> deleteAllData() async {
    await deleteUserProfile();
    await deleteAllTasks();
  }
}
