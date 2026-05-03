import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Темадан негізгі түстерді аламыз
    final theme = Theme.of(context);

    return Scaffold(
      // Scaffold-тың өзі темаға байланысты түсін өзгертеді
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/vector2.png",
                  width: 200, // Өлшемін нақтыладық
                ),
                const SizedBox(height: 10),
                Text(
                  "FinTrack",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    // Түсі автоматты түрде темаға (ақ/қара) қарай өзгереді
                  ),
                ),
                const SizedBox(height: 40),
                
                // Log In батырмасы (Primary Style)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Welcome -> login tap');
                      context.go('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary, // Жасыл түс (AppTheme-ден)
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Sign Up батырмасы (Secondary Style)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton( // Дизайнды ажырату үшін Outlined қолданған дұрыс
                    onPressed: () => context.go('/register'),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                TextButton(
                  onPressed: () {
                    // Forgot password логикасы кейінірек
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
