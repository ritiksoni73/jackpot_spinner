import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jackpot_machine/presentation/controller/jackpot_controller.dart';

class MultiRollerWidget extends GetView<JackpotController> {
  const MultiRollerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Transform(
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
                          controller: controller.controller1,
                          items: controller.items,
                          boxHeight: 200,
                          boxWidth: 20,
                          rollerHeight: 100,
                          onSping: (index) {},
                        ),
                        Container(height: 200, width: 2, color: Colors.grey),
                        _rollerView(
                          controller: controller.controller2,
                          items: controller.items,
                          boxHeight: 200,
                          boxWidth: 20,
                          rollerHeight: 100,
                          onSping: (index) {},
                        ),
                        Container(height: 200, width: 2, color: Colors.grey),
                        _rollerView(
                          controller: controller.controller3,
                          items: controller.items,
                          boxHeight: 200,
                          boxWidth: 20,
                          rollerHeight: 100,
                          onSping: (index) {},
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
    );
  }

  Expanded _rollerView({
    required CarouselSliderController controller,
    required List<String> items,
    required double boxHeight,
    required boxWidth,
    required rollerHeight,
    required Function(int) onSping,
  }) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: boxHeight,
            width: boxWidth,
            child: CarouselSlider(
              carouselController: controller,
              items: items
                  .map(
                    (e) => Text(
                      e,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList(),

              options: CarouselOptions(
                height: rollerHeight,
                viewportFraction: 0.4,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                onPageChanged: (v, r) {
                  onSping(v);
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
