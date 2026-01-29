import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_machine/core/constants/string_constants.dart';

class TiltedButton extends StatelessWidget {
  const TiltedButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.3)
        ..rotateY(0),
      child: Container(
        height:  kIsWeb
            ? MediaQuery.of(context).size.height / 4
            : 150,
        width: kIsWeb
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.black],
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
        child: GestureDetector(
          onTap: onTap,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-0.1)
              ..rotateY(0),
            child: Center(
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.grey],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                      offset: Offset(10, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    StringConstants.spin,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 100, 60, 60),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
