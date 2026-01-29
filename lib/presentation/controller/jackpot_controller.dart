import 'package:get/get.dart';

class JackpotController extends GetxController {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  RxBool showWin = false.obs;

  Future<void> celebrateWin(bool value) async {
    showWin.value = value;
    await Future.delayed(Duration(seconds: 1), () {
      showWin.value = false;
    });
  }
}
