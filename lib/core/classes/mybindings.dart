import 'package:fifthproject/controller/onboardingcontorller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OnBoardingController());
  }
}
