import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:flutter/material.dart';

class SharedItemWidget extends StatelessWidget {
  const SharedItemWidget({Key? key, required this.model}) : super(key: key);
  final NavigationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: () {
        if (model.onTap != null) {
          model.onTap!();
        }
      },
      child: Container(
        height: 12.appHeight(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.blueColor1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          children: [
            Container(
              height: 6.appHeight(context),
              width: 6.appHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Image.asset(
                model.image,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              model.name,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: AppFonts.font15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Image.asset(
              AppImages.arrow,
            ),
          ],
        ),
      ),
    );
  }
}
