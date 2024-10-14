import 'package:flutter/material.dart';

import '../utils/app_images.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.noData,
      ),
    );
  }
}
