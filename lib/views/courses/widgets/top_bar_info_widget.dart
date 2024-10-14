
import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/auth_provider.dart';
import 'package:courses_app/views/notifications/notifications_screen.dart';
import 'package:courses_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarInfoWidget extends StatelessWidget {
  const TopBarInfoWidget({
    Key? key,
    this.showNotification = true,
  }) : super(key: key);
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.topPadding() + 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.blueColor2,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.push(
                    const ProfileScreen(),
                  );
                },
                child: Image.asset(
                  AppImages.testProfile,
                  height: 45,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, ',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.font18,
                    ),
                  ),
                  Text(
                    context.read<AuthProvider>().userModel.name,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.font18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // if (showNotification)
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: () {
                        context.push(
                          const NotificationsScreen(),
                        );
                      },
                      child: Image.asset(
                        AppImages.whiteNotifications,
                        color: Colors.black,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
