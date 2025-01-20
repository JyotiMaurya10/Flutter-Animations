import 'package:get/get.dart';
import 'package:quiz_app/bindings/all_bindings.dart';

class InitialBinding implements Bindings {
  
  @override
  void dependencies() {
    AllBindings().allBindingInitialize();
  }
}
