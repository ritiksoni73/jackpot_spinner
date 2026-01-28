import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jackpot_machine/core/constants/string_constants.dart';
import 'package:jackpot_machine/presentation/controller/jackpot_controller.dart';

import '../widgets/multi_roller_widget.dart';

class JackpotView extends GetView<JackpotController> {
  const JackpotView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  MultiRollerWidget(
                    items: controller.items,
                    onComplete: (value) {
                      controller.showWin.value = value;
                    },
                  ),
                  Obx(
                    () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: controller.showWin.value ? 1 : 0,
                      child: Center(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 400),
                          scale: controller.showWin.value ? 1 : 0,
                          curve: Curves.elasticOut,
                          child: Image.network(
                            StringConstants.winImage,
                            width: 250,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
