import 'package:flutter/cupertino.dart';

import '../../../core/utils/app_colors.dart';
import '../../../models/message_model.dart';

class MyMessageItemWidget extends StatelessWidget {
  const MyMessageItemWidget({
    Key? key, required this.model,
  }) : super(key: key);
final MessageModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: AppColors.blueColor1,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child:  Text(
          model.message,
          style:const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
