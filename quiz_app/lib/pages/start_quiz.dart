import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/pages/quiz_screen.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/utils/styles.dart';
import 'package:quiz_app/widgets/arrow_animation.dart';
import 'package:quiz_app/widgets/background_painter.dart';

class StartQuiz extends StatefulWidget {
  final bool uponCompletion;
  const StartQuiz({
    super.key,
    this.uponCompletion = false,
  });

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  final QuizController quizController = Get.find();

  @override
  void initState() {
    super.initState();
    if (!widget.uponCompletion) {
      quizController.fetchQuiz();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
            Obx(() {
              if (quizController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: highlightColor),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      quizController.quiz.value!.title,
                      style: highlight24SemiBoldTextStyle.copyWith(fontSize: 44),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      quizController.quiz.value!.topic,
                      textAlign: TextAlign.center,
                      style: highlight16SemiBoldTextStyle.copyWith(color: disableColor),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => Get.to(() => const HomeScreen()),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                "Start Quiz",
                                style: heading16SemiBoldTextStyle.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const ArrowAnimation()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ));
  }
}
