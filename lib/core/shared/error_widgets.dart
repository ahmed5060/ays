import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
SnackBar networkErrorWidget() {
  return SnackBar(
    backgroundColor: AppColors.baseColor,
    content:const Text(
    'Network error',
      style:  TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  );
}

SnackBar unExpectedErrorWidget([String? message]) {
  return SnackBar(
    backgroundColor: AppColors.baseColor,
    content: Text(
      message?? 'Unexpected error',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  );
}

SnackBar successWidget(String message) {
  return SnackBar(
    backgroundColor: AppColors.baseColor,
    content: Text(
      message,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    ),
  );
}
