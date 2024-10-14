import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../core/extension/context_extention.dart';
import '../../core/utils/app_constants.dart';
import '../../views/start/start_screen.dart';

import '../../main.dart';
import '../shared/error_widgets.dart';

class Exceptions {
  static networkException() {
    ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
      networkErrorWidget(),
    );
  }

  static updateException([String? message]) {}

  static unAuthException() async {
    unExpectedException();
    await Hive.box(AppConstants.myBox).clear();
    Future.delayed(Duration.zero, () {
      MyApp.navigatorKey.currentContext!.pushAndRemoveUtils(
        const StartScreen(),
      );
    });
  }

  static unExpectedException([String? message]) {
    ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
      unExpectedErrorWidget(message),
    );
  }

  static success(String message) {
    ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
      successWidget(message),
    );
  }
}
