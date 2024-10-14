
import 'package:flutter/material.dart';

extension SizeExtension on num {
  double appHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 100);

  double appWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 100);
}

extension AppSize on BuildContext {
  double appHeight() {
    return MediaQuery.of(this).size.height;
  }

  double appWidth() {
    return MediaQuery.of(this).size.width;
  }
}
extension Navigation on BuildContext {
  void navigateTo(Widget screen) => Navigator.of(this).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}
