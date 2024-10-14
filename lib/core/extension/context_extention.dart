import 'package:flutter/material.dart';

extension Navigate on BuildContext {
  double topPadding() {
    return MediaQuery.of(this).padding.top;
  }

  push(Widget screen) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (ctx) => screen),
    );
  }

  pop() async => Navigator.pop(this);

  pushReplacement(Widget screen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (ctx) => screen,
      ),
    );
  }

  pushAndRemoveUtils(Widget screen) async {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (ctx) => screen),
      (route) => false,
    );
  }
}
