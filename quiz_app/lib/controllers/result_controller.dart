import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class ResultController extends GetxController with GetSingleTickerProviderStateMixin {
  var scaleCompleted = false.obs;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      animationController.forward().then((_) {
        animationController.reverse();
        scaleCompleted.value = true;
      });
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
