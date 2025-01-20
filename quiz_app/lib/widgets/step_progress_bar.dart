import 'package:quiz_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar({super.key, required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: Get.width,
      decoration: BoxDecoration(
        color: disableColorShade,
        borderRadius: BorderRadius.circular(30),
      ),
      child: FractionallySizedBox(
        widthFactor: (currentStep + 1) / totalSteps,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: highlightColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
