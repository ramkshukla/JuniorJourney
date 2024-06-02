import 'package:flutter/material.dart';

class NextAndBackBtn extends StatelessWidget {
  final VoidCallback nextFunction;
  final VoidCallback backFunction;

  NextAndBackBtn({required this.nextFunction, required this.backFunction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: backFunction,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 50),
                child: Image.asset(
                  'assets/images/back.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: nextFunction,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Image.asset(
                  'assets/images/next.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
