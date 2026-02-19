import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Artificial delay for splash effect (optional, keep it short)
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final localStorage = LocalStorageService();
    // Check local persistence first to prevent flicker
    final isLoggedIn = localStorage.isLoggedIn;

    if (isLoggedIn) {
      // Navigate to Home
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Navigate to Login
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example logo or text
            const Icon(Icons.fitness_center, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Text(
              'Eternal Grind',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
