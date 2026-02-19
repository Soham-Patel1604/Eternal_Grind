import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- User Methods ---

  Future<void> createUser(String uid, String email) async {
    try {
      await _db.collection('users').doc(uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'themeMode': 'system',
        'currentStreak': 0,
        'penalty': 0,
        'lastTaskDate': null,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  Future<void> updateTheme(String uid, bool isDark) async {
    try {
      await _db.collection('users').doc(uid).update({
        'themeMode': isDark ? 'dark' : 'light',
      });
    } catch (e) {
      print('Failed to sync theme: $e');
    }
  }

  Future<void> updateUserStats(String uid, {int? streak, int? penalty, DateTime? lastTaskDate}) async {
    Map<String, dynamic> data = {};
    if (streak != null) data['currentStreak'] = streak;
    if (penalty != null) data['penalty'] = penalty;
    if (lastTaskDate != null) data['lastTaskDate'] = Timestamp.fromDate(lastTaskDate);
    
    if (data.isNotEmpty) {
       await _db.collection('users').doc(uid).update(data);
    }
  }

  // --- Task Methods ---

  Future<void> addTask(String uid, String title, String description, {DateTime? createdAt}) async {
    try {
      await _db.collection('users').doc(uid).collection('tasks').add({
        'title': title,
        'description': description,
        'isCompleted': false,
        'createdAt': createdAt != null 
            ? Timestamp.fromDate(createdAt)
            : FieldValue.serverTimestamp(),
        'completedAt': null,
      });
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Stream<List<Task>> getTasksStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<Task>> getTasksForDateStream(String uid, DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return _db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('createdAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<List<Task>> getTasksForDate(String uid, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('createdAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => Task.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> toggleTaskStatus(String uid, String taskId, bool isCompleted) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'isCompleted': isCompleted,
        'completedAt': isCompleted ? FieldValue.serverTimestamp() : null,
      });
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String uid, String taskId) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
