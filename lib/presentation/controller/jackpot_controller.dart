import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class JackpotController extends GetxController {
  late CarouselSliderController controller1 = CarouselSliderController();
  late CarouselSliderController controller2 = CarouselSliderController();
  late CarouselSliderController controller3 = CarouselSliderController();
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8", "8", "9"];

  RxBool showWin = false.obs;
  void scrollAllToIndex() {
    final first = Random().nextInt(items.length);
    final second = Random().nextInt(items.length);
    final third = Random().nextInt(items.length);
    controller1.animateToPage(first);
    controller2.animateToPage(second);
    controller3.animateToPage(third);
    if (first == second && second == third) {
      showWin.value = true;
      Future.delayed(Duration(seconds: 1), () {
        showWin.value = false;
      });
    }
  }

  void makeWinner() {
    final same = Random().nextInt(items.length);
    final first = same;
    final second = same;
    final third = same;
    controller1.animateToPage(first);
    controller2.animateToPage(second);
    controller3.animateToPage(third);
    if (first == second && second == third) {
      showWin.value = true;
      Future.delayed(Duration(seconds: 1), () {
        showWin.value = false;
      });
    }
  }
}
