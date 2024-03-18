import 'package:get/get.dart';

import '../screens/onboarding/onboarding_design.dart';

class OnBoardingController extends GetxController {
  bool _isLastPage = false;
  int _indexpage = 0;

  int get indexpage => _indexpage;
  set indexpage(int newindex) {
    _indexpage = newindex;
    update();
  }

  bool get isLastPage => _isLastPage;
  set isLastPage(bool newvalue) {
    _isLastPage = newvalue;
    update();
  }

  void InLastPage() {
    _indexpage == pages.length - 1 ? _isLastPage = true : _isLastPage = false;
    update();
  }
}
