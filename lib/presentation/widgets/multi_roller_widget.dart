import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jackpot_machine/presentation/widgets/tilted_button.dart';

class MultiRollerWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<bool> onComplete;

  MultiRollerWidget({super.key, required this.items, required this.onComplete});

  final ScrollController controller1 = ScrollController();
  final ScrollController controller2 = ScrollController();
  final ScrollController controller3 = ScrollController();
  final double itemHeight = 60;
  final double lastScroll = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbsorbPointer(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.2)
              ..rotateY(0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 20,
                    offset: Offset(10, 10),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _rollerView(
                                controller: controller1,
                                items: items,
                                boxHeight: 200,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                              Container(
                                height: 200,
                                width: 2,
                                color: Colors.grey,
                              ),
                              _rollerView(
                                controller: controller2,
                                items: items,
                                boxHeight: 200,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                              Container(
                                height: 200,
                                width: 2,
                                color: Colors.grey,
                              ),
                              _rollerView(
                                controller: controller3,
                                items: items,
                                boxHeight: 200,
                                boxWidth: 20,
                                itemHeight: itemHeight,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        TiltedButton(onTap: _spin, onDoubleTap: _spinToWin),
      ],
    );
  }

  Expanded _rollerView({
    required ScrollController controller,
    required List<String> items,
    required double boxHeight,
    required boxWidth,
    required itemHeight,
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

  Map<ScrollController, double> track = {};
  Future<void> _animateToElement({
    required ScrollController controller,
    required int itemLength,
    required int targetIndex,
    int rounds = 2,
  }) async {
    controller.jumpTo(0);
    final fixRoundOffset = itemHeight * itemLength * rounds.toDouble();
    await controller.animateTo(
      fixRoundOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
    if (track[controller] == null) {
      track[controller] = fixRoundOffset + (itemHeight * targetIndex.toDouble());
    } else {
      track[controller] = track[controller]! + fixRoundOffset + (itemHeight * targetIndex.toDouble());
    }
    await controller.animateTo(
      track[controller]!,
      duration: const Duration(seconds: 4),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _spin() async {
    final first = Random().nextInt(items.length);
    final second = Random().nextInt(items.length);
    final third = Random().nextInt(items.length);
    _animateToElement(
      controller: controller1,
      itemLength: items.length,
      targetIndex: first,
    );
    _animateToElement(
      controller: controller2,
      itemLength: items.length,
      targetIndex: second,
    );
    _animateToElement(
      controller: controller3,
      itemLength: items.length,
      targetIndex: third,
    );
    if (first == second && second == third) {
      await Future.delayed(Duration(milliseconds: 4400), () {
        onComplete(true);
      });
    }
    onComplete(false);
  }

  Future<void> _spinToWin() async {
    final num = Random().nextInt(items.length);
    _animateToElement(
      controller: controller1,
      itemLength: items.length,
      targetIndex: num,
    );
    _animateToElement(
      controller: controller2,
      itemLength: items.length,
      targetIndex: num,
    );
    _animateToElement(
      controller: controller3,
      itemLength: items.length,
      targetIndex: num,
    );
    await Future.delayed(Duration(milliseconds: 4400), () {
      onComplete(true);
    });
    await Future.delayed(Duration(seconds: 1), () {
      onComplete(false);
    });
  }
}
