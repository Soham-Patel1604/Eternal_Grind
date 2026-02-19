import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUid = 'uid';
  static const String keyEmail = 'email';
  static const String keyThemeMode = 'themeMode';

  late SharedPreferences _prefs;

  // Singleton pattern
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Auth Data
  Future<void> setAuthData({required String uid, required String email}) async {
    await _prefs.setBool(keyIsLoggedIn, true);
    await _prefs.setString(keyUid, uid);
    await _prefs.setString(keyEmail, email);
  }

  Future<void> clearAuthData() async {
    await _prefs.remove(keyIsLoggedIn);
    await _prefs.remove(keyUid);
    await _prefs.remove(keyEmail);
    // Note: We might want to keep themeMode even after logout, or clear it.
    // Prompt says "Logout clears: Firebase session, Local cache".
    // I will keep themeMode for better UX, or clear it if strictly following "Login screen only" which might imply reset.
    // Prompt: "Logout clears ... Local cache". I'll clear keyThemeMode too if requested? 
    // "Persist theme: Locally (SharedPreferences)". Usually theme is global. 
    // "Logout clears ... Local cache". I will clear strictly auth data. 
    // But Step 5 says "Logout clears: ... Local cache".
    // Step 4 says "On theme change -> update Firestore + local storage". 
    // I will clear everything to be safe per the "Logout clears Local cache" instruction.
    await _prefs.remove(keyThemeMode);
  }

  bool get isLoggedIn => _prefs.getBool(keyIsLoggedIn) ?? false;
  String? get uid => _prefs.getString(keyUid);
  String? get email => _prefs.getString(keyEmail);

  // Theme
  Future<void> setThemeMode(bool isDark) async {
    await _prefs.setBool(keyThemeMode, isDark);
  }

  bool? get isDarkMode => _prefs.getBool(keyThemeMode);
}
