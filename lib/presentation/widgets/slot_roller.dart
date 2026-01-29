import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jackpot_machine/core/constants/string_constants.dart';

import 'left_triangle.dart';
import 'right_triangle.dart';

class SlotRoller extends StatelessWidget {
  final int rounds;

  final List<String> items;
  final ValueChanged<bool> onComplete;

  SlotRoller({
    super.key,
    required this.rounds,
    required this.items,
    required this.onComplete,
  });

  final ScrollController controller1 = ScrollController();

  final ScrollController controller2 = ScrollController();

  final ScrollController controller3 = ScrollController();

  final double itemHeight = 60;

  final double lastScroll = 0;

  Map<ScrollController, double> track = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              upperSlot(),
              buttonBase(),
              Positioned(bottom: 60, child: button()),
              Positioned(
                top: 140,
                child: SizedBox(
                  width: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomPaint(
                        size: const Size(24, 24),
                        painter: LeftTrianglePainter(Colors.white),
                      ),
                      CustomPaint(
                        size: const Size(24, 24),
                        painter: RightTrianglePainter(Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 140,
              //   left: 90,
              //   child: CustomPaint(
              //     size: const Size(24, 24),
              //     painter: LeftTrianglePainter(Colors.white),
              //   ),
              // ),
              // Positioned(
              //   top: 140,
              //   right: 90,
              //   child: CustomPaint(
              //     size: const Size(24, 24),
              //     painter: RightTrianglePainter(Colors.white),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Transform button() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.7)
        ..rotateY(0),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _spin,
          onDoubleTap: _spinToWin,
          child: Container(
            height: 100,
            width: 250,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                transform: GradientRotation(-0.5),
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB9CBD7),
                  Color(0xFF5992B7),
                  Color(0xFF224962),
                  Color(0xFF0C5585),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border(
                left: BorderSide(color: Colors.white),
                bottom: BorderSide(color: Colors.white),
                right: BorderSide(color: Colors.white),
              ),
            ),
            child: Center(
              child: Text(
                StringConstants.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Transform buttonBase() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.7)
        ..rotateY(0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 150,
          width: 314,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.7),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.blue.withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB9CBD7), Color(0xFF3C80AD)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            border: Border(
              left: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
              right: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Column upperSlot() {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 340,
            width: 300,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.7),
                  blurRadius: 30,
                  spreadRadius: -4,
                  offset: Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.blue.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, -2),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3C80AD),
                  Color(0xFF7599B0),
                  Color(0xFF7599B0),
                  Color(0xFFB9CBD7),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              border: Border(
                left: BorderSide(color: Colors.white),
                top: BorderSide(color: Colors.white),
                right: BorderSide(color: Colors.white),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  height: 268,
                  width: 268,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFB9CBD7),
                        Color(0xFF7599B0),
                        Color(0xFF7599B0),
                        Color(0xFF3C80AD),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x6C484B54),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AbsorbPointer(
                      child: Center(
                        child: SizedBox(
                          height: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _rollerView(
                                controller: controller1,
                                items: items,
                                boxHeight: 180,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                              Container(
                                height: 180,
                                width: 2,
                                color: Colors.grey,
                              ),
                              _rollerView(
                                controller: controller2,
                                items: items,
                                boxHeight: 180,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                              Container(
                                height: 180,
                                width: 2,
                                color: Colors.grey,
                              ),
                              _rollerView(
                                controller: controller3,
                                items: items,
                                boxHeight: 180,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 128),
      ],
    );
  }

  Expanded _rollerView({
    required ScrollController controller,
    required List<String> items,
    required double boxHeight,
    required double boxWidth,
    required double itemHeight,
  }) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: boxHeight,
            width: boxWidth,
            child: ListView.builder(
              controller: controller,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final char = items[index % items.length];
                return SizedBox(
                  height: itemHeight,
                  child: Center(
                    child: Text(
                      char,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _animateToElement({
    required ScrollController controller,
    required int itemLength,
    required int targetIndex,
  }) async {
    final double totalItemsHeight = itemHeight * itemLength;
    final double fixRoundOffset = totalItemsHeight * rounds;
    if (track[controller] == null) {
      track[controller] = 0;
    }

    final double targetPosition =
        track[controller]! + fixRoundOffset + (itemHeight * targetIndex);
    await controller.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500 + (rounds * 300)),
      curve: Curves.decelerate,
    );
    track[controller] = targetPosition;
  }

  Future<void> _spin() async {
    track[controller1] = controller1.offset;
    track[controller2] = controller2.offset;
    track[controller3] = controller3.offset;

    final first = Random().nextInt(items.length);
    final second = Random().nextInt(items.length);
    final third = Random().nextInt(items.length);
    await Future.wait([
      _animateToElement(
        controller: controller1,
        itemLength: items.length,
        targetIndex: first,
      ),
      _animateToElement(
        controller: controller2,
        itemLength: items.length,
        targetIndex: second,
      ),
      _animateToElement(
        controller: controller3,
        itemLength: items.length,
        targetIndex: third,
      ),
    ]);
    if (first == second && second == third) {
      await Future.delayed(Duration(milliseconds: (rounds * 300)));
      onComplete(true);
    } else {
      onComplete(false);
    }
  }

  Future<void> _spinToWin() async {
    final num = Random().nextInt(items.length);
    track[controller1] = controller1.offset;
    track[controller2] = controller2.offset;
    track[controller3] = controller3.offset;
    track.forEach((k, v) {
      track[k] =
          v +
          (items.length -
                  ((v % (itemHeight * items.length * rounds)) / itemHeight)) *
              itemHeight;
    });
    await Future.wait([
      _animateToElement(
        controller: controller1,
        itemLength: items.length,
        targetIndex: num,
      ),
      _animateToElement(
        controller: controller2,
        itemLength: items.length,
        targetIndex: num,
      ),
      _animateToElement(
        controller: controller3,
        itemLength: items.length,
        targetIndex: num,
      ),
    ]);
    await Future.delayed(Duration(milliseconds: (rounds * 300)));
    onComplete(true);
  }
}
