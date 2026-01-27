import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:jackpot_machine/presentation/controller/jackpot_controller.dart';

class JackpotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JackpotController());
  }
}
