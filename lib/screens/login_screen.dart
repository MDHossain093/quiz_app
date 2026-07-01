import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/custom_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz, size: 100, color: AppColors.primary),
              const SizedBox(height: 20),
              const Text(
                "Quiz Master",
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 8),
              const Text(
                "Sign in to start today's challenge.",
                style: AppTextStyles.subtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: "Continue with Google",
                icon: Icons.login,
                onPressed: () async {
                  final user = await authService.signInWithGoogle();

                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Google sign-in failed")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
