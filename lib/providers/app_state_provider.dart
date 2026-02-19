import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import '../services/task_service.dart';
import '../services/streak_service.dart';
import '../services/curse_service.dart';
import '../services/validation_service.dart';

class AppStateProvider with ChangeNotifier {
  final StorageService _storage;
  final TaskService _taskService;
  final StreakService _streakService;
  final CurseService _curseService;
  final ValidationService _validationService;

  UserProfile? _profile;
  List<Task> _tasks = [];
  bool _isLoading = true;
  String? _milestoneMessage;

  AppStateProvider({
    required StorageService storage,
    required TaskService taskService,
    required StreakService streakService,
    required CurseService curseService,
    required ValidationService validationService,
  })  : _storage = storage,
        _taskService = taskService,
        _streakService = streakService,
        _curseService = curseService,
        _validationService = validationService;

  // Getters
  UserProfile? get profile => _profile;
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get milestoneMessage => _milestoneMessage;
  bool get isCursed => _profile?.cursedMark.isCursed ?? false;
  bool get isInRecovery => _profile?.streakData.isInRecovery ?? false;

  /// Initialize the app state
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _storage.getUserProfile();
      
      if (_profile == null) {
        // First time user
        _profile = UserProfile.initial();
        await _storage.saveUserProfile(_profile!);
      } else {
        // Existing user - check for day transitions
        await _handleDayTransition();
      }

      _tasks = await _taskService.getTasks();
      
      // Check if account should be deleted
      if (_curseService.shouldDeleteAccount(_profile!.cursedMark)) {
        await _deleteAccount();
        return;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Handles day transition logic
  Future<void> _handleDayTransition() async {
    final now = DateTime.now();
    final lastOpened = _profile!.lastOpenedDate;

    // Validate day transition
    if (!_validationService.isValidDayTransition(lastOpened, now)) {
      // Time rollback detected - do nothing or show warning
      return;
    }

    // Check if it's the same day
    if (_validationService.isSameDay(lastOpened, now)) {
      return; // Same day, no transition needed
    }

    // Check if it's the next day
    if (_validationService.isNextDay(lastOpened, now)) {
      await _handleNextDay(now);
    } else {
      // Multiple days missed
      final missedDays = _validationService.calculateMissedDays(lastOpened, now);
      await _handleMissedDays(missedDays, now);
    }

    // Update last opened date
    _profile = _profile!.copyWith(
      lastOpenedDate: now,
      totalActiveDays: _profile!.totalActiveDays + 1,
    );
    await _storage.saveUserProfile(_profile!);
  }

  /// Handles next day transition
  Future<void> _handleNextDay(DateTime now) async {
    // Reset tasks
    await _taskService.resetDailyTasks();
    _tasks = await _taskService.getTasks();

    // If user was in recovery or cursed, increment counters
    if (_profile!.cursedMark.isCursed) {
      _profile = _profile!.copyWith(
        cursedMark: _curseService.incrementDaysCursed(_profile!.cursedMark),
      );
    }

    if (_profile!.streakData.isInRecovery) {
      _profile = _profile!.copyWith(
        cursedMark: _curseService.incrementRecoveryDays(_profile!.cursedMark),
      );
    }

    // Mark as no longer first day
    if (_profile!.isFirstDay) {
      _profile = _profile!.copyWith(isFirstDay: false);
    }
  }

  /// Handles multiple missed days
  Future<void> _handleMissedDays(int missedDays, DateTime now) async {
    // Try to consume relief days
    var reliefDay = _profile!.reliefDay;
    var cursedMark = _profile!.cursedMark;
    var streakData = _profile!.streakData;

    for (int i = 0; i < missedDays; i++) {
      final (updatedRelief, consumed) = _curseService.tryConsumeReliefDay(reliefDay);
      reliefDay = updatedRelief;

      if (!consumed) {
        // No relief day available - apply curse
        cursedMark = _curseService.applyCurse(cursedMark);
        streakData = _streakService.breakStreak(streakData);
        
        // Start recovery if not already in recovery
        if (!streakData.isInRecovery) {
          streakData = _streakService.startRecovery(streakData, cursedMark.count);
        }
      }
    }

    _profile = _profile!.copyWith(
      reliefDay: reliefDay,
      cursedMark: cursedMark,
      streakData: streakData,
    );

    // Reset tasks
    await _taskService.resetDailyTasks();
    _tasks = await _taskService.getTasks();

    // Mark as no longer first day
    if (_profile!.isFirstDay) {
      _profile = _profile!.copyWith(isFirstDay: false);
    }
  }

  /// Complete the day (all tasks done)
  Future<void> completeDay() async {
    if (_profile == null) return;

    final now = DateTime.now();
    var streakData = _profile!.streakData;
    var reliefDay = _profile!.reliefDay;

    // Only increment if not already completed today
    if (_validationService.isSameDay(streakData.lastCompletionDate, now)) {
      return;
    }

    if (streakData.isInRecovery) {
      // In recovery mode
      streakData = _streakService.incrementRecovery(streakData, now);

      if (_streakService.isRecoveryComplete(streakData)) {
        // Recovery complete - remove curse
        streakData = _streakService.completeRecovery(streakData);
        final cursedMark = _curseService.removeCurse(_profile!.cursedMark);
        _profile = _profile!.copyWith(
          streakData: streakData,
          cursedMark: cursedMark,
        );
      } else {
        _profile = _profile!.copyWith(streakData: streakData);
      }
    } else {
      // Normal streak increment
      streakData = _streakService.incrementStreak(streakData, now);

      // Check for milestone
      if (_streakService.isMilestone(streakData.currentStreak)) {
        _milestoneMessage = _streakService.getMilestoneMessage(streakData.currentStreak);

        // Check if milestone earns relief day
        if (_streakService.earnsReliefDay(streakData.currentStreak)) {
          reliefDay = _curseService.awardReliefDay(reliefDay);
        }
      }

      _profile = _profile!.copyWith(
        streakData: streakData,
        reliefDay: reliefDay,
      );
    }

    await _storage.saveUserProfile(_profile!);
    notifyListeners();
  }

  /// Add a new task (Day 1 only)
  Future<void> addTask(String title) async {
    if (_profile == null) return;
    await _taskService.addTask(title, _profile!.isFirstDay);
    _tasks = await _taskService.getTasks();
    notifyListeners();
  }

  /// Remove a task (Day 1 only)
  Future<void> removeTask(String taskId) async {
    await _taskService.removeTask(taskId, _profile!.isFirstDay);
    _tasks = await _taskService.getTasks();
    notifyListeners();
  }

  /// Toggle task completion
  Future<void> toggleTask(String taskId) async {
    await _taskService.toggleTaskCompletion(taskId);
    _tasks = await _taskService.getTasks();

    // Check if all tasks are completed
    if (await _taskService.areAllTasksCompleted()) {
      await completeDay();
    }

    notifyListeners();
  }

  /// Clear milestone message
  void clearMilestoneMessage() {
    _milestoneMessage = null;
    notifyListeners();
  }

  /// Delete account (at 10 cursed marks)
  Future<void> _deleteAccount() async {
    await _storage.deleteAllData();
    _profile = UserProfile.initial();
    _tasks = [];
    await _storage.saveUserProfile(_profile!);
    notifyListeners();
  }

  /// Finish Day 1 setup
  Future<void> finishDayOneSetup() async {
    if (_profile == null) return;

    // Validate minimum tasks
    if (!await _taskService.validateMinimumTasks()) {
      throw Exception('Must have at least 2 tasks');
    }

    _profile = _profile!.copyWith(
      isFirstDay: false,
      lastOpenedDate: DateTime.now(),
    );
    await _storage.saveUserProfile(_profile!);
    notifyListeners();
  }
}
