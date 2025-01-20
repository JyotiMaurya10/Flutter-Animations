import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/result_controller.dart';

class AllBindings {
  Future<void> allBindingInitialize() async {
    Get.lazyPut<QuizController>(() => QuizController(), fenix: true); 
    Get.lazyPut<ResultController>(() => ResultController(), fenix: true); 
  }
}
