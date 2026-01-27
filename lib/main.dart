import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:jackpot_machine/presentation/bining/jackpot_binding.dart';
import 'package:jackpot_machine/presentation/view/jackpot_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: JackpotView(),
      initialBinding: JackpotBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => JackpotView(),
          binding: JackpotBinding(),
        ),
      ],
    );
  }
}
