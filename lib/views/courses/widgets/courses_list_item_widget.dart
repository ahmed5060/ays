import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/network_image_widget.dart';
import 'package:courses_app/views/courses_details/courses_details_screen.dart';
import 'package:flutter/material.dart';
//
// import 'package:paymob_flutter/paymob_flutter.dart';
//

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/app_images.dart';
import '../../../models/course_model.dart';

class CoursesListItemWidget extends StatelessWidget {
  const CoursesListItemWidget({Key? key, required this.model})
      : super(key: key);
  final CourseModel model;
  // Future<void> startPayment() async {
  //   // Initialize Paymob with your API keys
  //   PaymobFlutter.initialize(
  //     apiKey: "your_api_key",
  //     integrationId: "your_integration_id",
  //     // other configurations...
  //   );

  //   // Use PaymobFlutter methods to start the payment process
  //   // (Actual methods might differ based on the plugin)
  //   // For example:
  //   PaymobFlutter.startPayment(
  //     amount: 100, // Amount in cents
  //     currency: "EGP", // Currency code
  //     orderId: "order123", // Your order ID
  //     // other parameters...
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 65.appHeight(context),
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: NetworkImageWidget(
                imageUrl: model.image,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 60.appHeight(context),
                width: 100.appWidth(context) - 60,
                color: Color.fromARGB(36, 0, 0, 0),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Image.asset(
              AppImages.courseBG,
              fit: BoxFit.fill,
              height: 20.appHeight(context),
              width: double.infinity,
            ),
            SizedBox(
              height: 20.appHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.blueColor1,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImages.calender,
                          height: 13,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.allowed ? 'Allowed' : 'Not Allowed',
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppFonts.font10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    model.name,
                    style: const TextStyle(
                      color: AppColors.blueColor1,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.font22,
                    ),
                  ),
                  model.allowed
                      ? GestureDetector(
                          onTap: () {
                            if (model.allowed) {
                              context.push(
                                CoursesDetailsScreen(
                                  courseModel: model,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.blueColor1,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Start Learning',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppFonts.font17,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // startPayment();
                            // if (model.allowed) {
                            //   context.push(
                            //     CoursesDetailsScreen(
                            //       courseModel: model,
                            //     ),
                            //   );
                            // }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.blueColor1,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Buy the course',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppFonts.font17,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
