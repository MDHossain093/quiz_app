import 'package:flutter/material.dart';

import '../models/question_model.dart';
import '../services/api_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/custom_button.dart';
import '../widget/custom_card.dart';
import '../widget/option_tile.dart';
import 'result_screen.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const QuizScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ApiService apiService = ApiService();

List<Question> questions = [];

int currentIndex = 0;
int score = 0;
int? selectedAnswer;

bool loading = true;

/// Timer
Timer? timer;
int timeLeft = 30;
  

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
  questions = await apiService.getQuestions(widget.categoryId);

  startTimer();

  setState(() {
    loading = false;
  });
}

void startTimer() {
  timer?.cancel();

  timeLeft = 30;

  timer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      if (!mounted) return;

      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        nextQuestion();
      }
    },
  );
}

  void nextQuestion() {
  timer?.cancel();

  if (selectedAnswer == questions[currentIndex].answerIndex) {
    score += questions[currentIndex].mark;
  }

  if (currentIndex == questions.length - 1) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: score,
          total: questions.length * 10,
        ),
      ),
    );
  } else {
    setState(() {
      currentIndex++;
      selectedAnswer = null;
    });

    startTimer();
  }
}
@override
void dispose() {
  timer?.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.categoryName)),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "No questions found for this category.",
              style: AppTextStyles.subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final question = questions[currentIndex];
    final progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    Text(
      "Question ${currentIndex + 1} of ${questions.length}",
      style: AppTextStyles.heading,
    ),

    AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: timeLeft <= 10
            ? AppColors.danger
            : AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        children: [

          const Icon(
            Icons.timer,
            color: Colors.white,
            size: 18,
          ),

          const SizedBox(width: 6),

          Text(
            "$timeLeft s",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    ),
  ],
),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: AppTextStyles.heading.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              question.options.length,
              (index) => OptionTile(
                value: index,
                groupValue: selectedAnswer,
                text: question.options[index],
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              ),
            ),
            const Spacer(),
            CustomButton(
              text: currentIndex == questions.length - 1 ? "Finish" : "Next",
              icon: Icons.arrow_forward,
              onPressed: selectedAnswer == null ? null : nextQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
