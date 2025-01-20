import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/result_controller.dart';
import 'package:quiz_app/pages/start_quiz.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/utils/styles.dart';
import 'package:quiz_app/widgets/background_painter.dart';

class ResultScreen extends StatefulWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int unansweredQuestions;
  final double score;
  final double percentage;
  final double totalScore;
  final String performanceText;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unansweredQuestions,
    required this.percentage,
    required this.performanceText,
    required this.score,
    required this.totalScore,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  final ResultController quizController = Get.find();

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text("Quiz Result", style: highlight24SemiBoldTextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 30),
                  child: ScaleTransition(
                    scale: quizController.scaleAnimation,
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: const BoxDecoration(
                        color: highlightColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: disableColorShade,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Center(
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 1),
                          tween: Tween(begin: 0, end: widget.percentage),
                          builder: (context, value, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${value.toStringAsFixed(0)}%",
                                style: heading24SemiBoldTextStyle.copyWith(
                                  color: greenColor,
                                  fontSize: 50,
                                ),
                              ),
                              Text(
                                "Score: ${widget.score.toStringAsFixed(0)} / ${widget.totalScore.toStringAsFixed(0)}",
                                style: heading16RegularTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ScaleTransition(
                  scale: quizController.scaleAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      widget.performanceText,
                      style: heading24SemiBoldTextStyle.copyWith(
                        fontSize: 30,
                        color: greenColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: disableColorShade, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildDetailRow("Questions", (widget.correctAnswers + widget.wrongAnswers + widget.unansweredQuestions).toString()),
                      const Divider(),
                      buildDetailRow("Correct Answers", widget.correctAnswers.toString()),
                      const Divider(),
                      buildDetailRow("Wrong Answers", widget.wrongAnswers.toString()),
                      const Divider(),
                      buildDetailRow("Unanswered Questions", widget.unansweredQuestions.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => const StartQuiz(
                            uponCompletion: true,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      child: const Text("🏠  Back to Home", style: highlight16SemiBoldTextStyle),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: heading16SemiBoldTextStyle.copyWith(
              color: disableColorShade,
            )),
        Text(value, style: heading16SemiBoldTextStyle),
      ],
    );
  }
}
