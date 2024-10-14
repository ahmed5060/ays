import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/providers/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shared/empty_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<NotificationsProvider>(
        context,
        listen: false,
      ).getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: const MainAppBarWidget(
          title: 'Notifications',
        ),
        body: provider.notifications.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemBuilder: (ctx, index) => Dismissible(
                  onDismissed: (dir) {},
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.blueColor2.withOpacity(0.65),
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.whiteColor,
                      size: 40,
                    ),
                  ),
                  key: Key(
                    '$index',
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.blueColor1,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.whiteColor,
                          ),
                          child: Image.asset(
                            AppImages.notifications,
                            scale: 1.2,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: 100.appWidth(context) - 150,
                          child: Text(
                            provider.notifications[index].message ?? '',
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: AppFonts.font15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: provider.notifications.length,
              )
            : Center(
                child: provider.getNotificationsLoading
                    ? const LoadingWidget()
                    : const EmptyWidget(),
              ),
      );
    });
  }
}
