import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/utils/styles.dart';
import 'package:quiz_app/widgets/options_button.dart';
import 'package:quiz_app/widgets/primary_button.dart';
import 'package:quiz_app/widgets/step_progress_bar.dart';
import 'package:quiz_app/widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuizController quizController = Get.find();

  @override
  void initState() {
    super.initState();
    quizController.pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    quizController.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: highlightColor,
      body: SingleChildScrollView(child: Obx(() {
        final quiz = quizController.quiz.value!;
        return Column(
          children: [
            ClipPath(
              clipper: CustomCurveClipper(),
              child: Container(
                height: Get.height * 0.45,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
                        child: Obx(
                          () => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Question ${quizController.currentStep.value + 1} of ${quiz.questions.length}",
                                  style: highlight16SemiBoldTextStyle,
                                ),
                              ),
                              StepProgressBar(
                                currentStep: quizController.currentStep.value,
                                totalSteps: quiz.questions.length,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: PageView.builder(
                            itemCount: quiz.questions.length,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: quizController.pageController,
                            itemBuilder: (context, index) {
                              return carouselView(index, quiz.questions[index].description);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      "Select the correct answer",
                      style: heading16RegularTextStyle.copyWith(color: disableColorShade),
                    ),
                    Obx(() {
                      final currentQuestion = quizController.quiz.value!.questions[quizController.currentPage];
                      final selectedIndex = quizController.selectedOptionIndices[quizController.currentPage];

                      return Column(
                        children: List.generate(
                          currentQuestion.options.length,
                          (optionIndex) {
                            final option = currentQuestion.options[optionIndex];

                            return GestureDetector(
                              onTap: () {
                                quizController.selectedOptionIndices[quizController.currentPage] = optionIndex;
                              },
                              child: OptionsButton(
                                option: option.description,
                                isSelected: selectedIndex == optionIndex,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quizController.currentPage > 0
                              ? PrimaryButton(
                                  text: "Prev",
                                  onTap: () {
                                    quizController.previousStep();
                                  },
                                )
                              : const SizedBox(width: 10),
                          PrimaryButton(
                            text: quizController.currentPage + 1 < quizController.quiz.value!.questions.length ? "Next" : "Submit",
                            onTap: () {
                              if (quizController.currentPage + 1 < quizController.quiz.value!.questions.length) {
                                quizController.nextStep();
                              } else {
                                quizController.calculateResults();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      })),
    );
  }

  Widget carouselView(int index, String question) {
    return AnimatedBuilder(
      animation: quizController.pageController,
      builder: (context, child) {
        double value = 0.0;
        if (quizController.pageController.position.haveDimensions) {
          value = index.toDouble() - (quizController.pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        } else {
          value = index == quizController.currentPage ? 0.0 : (index - quizController.currentPage) * 0.038;
          value = value.clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(question),
        );
      },
    );
  }

  Widget carouselCard(String question) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)]),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      question,
                      style: heading14SemiBoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
