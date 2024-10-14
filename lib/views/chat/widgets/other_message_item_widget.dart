import 'package:courses_app/core/extension/size_extension.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/app_colors.dart';
import '../../../models/message_model.dart';

class OtherMessageItemWidget extends StatelessWidget {
  const OtherMessageItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          model.name,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 60.appWidth(context),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
            color: AppColors.greyColor1,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text(
            model.message,
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
