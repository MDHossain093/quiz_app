import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/custom_button.dart';
import '../widget/custom_card.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total == 0 ? 0 : ((score / total) * 100).round();
    final message = percentage >= 80
        ? "Excellent!"
        : percentage >= 50
            ? "Good effort!"
            : "Keep practicing!";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 100,
                  color: AppColors.warning,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Congratulations",
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "$score / $total",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primary,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 8),
                Text(message, style: AppTextStyles.subtitle),
                const SizedBox(height: 40),
                CustomButton(
                  text: "Back Home",
                  icon: Icons.home,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
