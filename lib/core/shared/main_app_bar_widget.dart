import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';

import '../../views/profile/profile_screen.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget({
    Key? key,
    this.title = '',
    this.noBackPressed = false,
    this.backPressed,
  }) : super(key: key);
  final String title;
  final bool noBackPressed;
  final Function? backPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: noBackPressed
          ? const SizedBox()
          : IconButton(
              onPressed: () {
                if (backPressed != null) {
                  backPressed!();
                } else {
                  context.pop();
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.blueColor1,
              ),
            ),
      actions: [
        InkWell(
          onTap: () {
            context.push(
              const ProfileScreen(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              AppImages.testProfile,
            ),
          ),
        ),
      ],
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.blueColor1,
          fontSize: AppFonts.font16,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.infinity,
        kToolbarHeight,
      );
}
