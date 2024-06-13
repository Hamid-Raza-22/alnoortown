import 'package:get/get.dart';

class HomeController extends GetxController {
  var isTapped = false.obs;

  void toggleTapped() {
    isTapped.value = !isTapped.value;
  }
}
