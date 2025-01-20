import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app/pages/result_screen.dart';

class QuizController extends GetxController with GetSingleTickerProviderStateMixin {
  RxList<int> selectedOptionIndices = <int>[].obs;
  late AnimationController animationController;
  late PageController pageController;
  late Animation<double> arrowAnimation;
  late RxDouble arrowLength = 10.0.obs;
  Rxn<Quiz> quiz = Rxn<Quiz>();
  var isLoading = false.obs;
  var currentStep = 0.obs;
  int currentPage = 0;
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    arrowAnimation = Tween<double>(begin: 10.0, end: 40.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ),
    );

    arrowAnimation.addListener(() {
      arrowLength.value = arrowAnimation.value;
    });

    animationController.repeat(reverse: true);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Future<void> fetchQuiz() async {
    isLoading.value = true;
    try {
      final response = await dio.get('https://api.jsonserve.com/Uw5CrX');
      quiz.value = Quiz.fromJson(response.data);
      selectedOptionIndices.value = List.generate(quiz.value!.questions.length, (index) => -1);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void previousStep() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentStep.value = currentPage;
      quiz.refresh();
    }
  }

  void nextStep() {
    currentPage++;
    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    currentStep.value = currentPage;
    quiz.refresh();
  }

  void calculateResults() {
    if (quiz.value == null) return;

    int correctCount = 0, wrongCount = 0, unansweredCount = 0;
    double score = 0.0;
    double totalScore = quiz.value!.questions.length * quiz.value!.correctAnswerMarks;

    for (int i = 0; i < quiz.value!.questions.length; i++) {
      final question = quiz.value!.questions[i];
      int selectedIndex = selectedOptionIndices[i];

      if (selectedIndex == -1) {
        unansweredCount++;
      } else if (question.options[selectedIndex].isCorrect) {
        correctCount++;
        score += quiz.value!.correctAnswerMarks;
      } else {
        wrongCount++;
        score -= quiz.value!.negativeMarks;
      }
    }

    double percentage = (correctCount / quiz.value!.questions.length) * 100;
    String performanceText = getPerformanceText(percentage);

    Get.offAll(
      () => ResultScreen(
        correctAnswers: correctCount,
        wrongAnswers: wrongCount,
        unansweredQuestions: unansweredCount,
        performanceText: performanceText,
        percentage: percentage,
        score: score,
        totalScore: totalScore,
      ),
    );
  }

  String getPerformanceText(double percentage) {
    if (percentage >= 80) return "Outstanding!";
    if (percentage >= 50) return "Good Job!";
    return "Better Luck Next Time";
  }
}
