import 'dart:io';

import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/shared/empty_widget.dart';
import 'package:courses_app/core/shared/loading_widget.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/providers/courses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'courses_list_item_widget.dart';

class CoursesListWidget extends StatelessWidget {
  const CoursesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesProvider>(builder: (context, provider, _) {
      return Expanded(
        child: Platform.isWindows
            ? ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Courses',
                        style: TextStyle(
                          color: AppColors.blueColor1,
                          fontWeight: FontWeight.w500,
                          fontSize: AppFonts.font20,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     context.push(
                      //       const TestimonialsScreen(),
                      //     );
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12),
                      //       border: Border.all(
                      //         color: AppColors.blueColor1,
                      //       ),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 10,
                      //       vertical: 8,
                      //     ),
                      //     alignment: Alignment.center,
                      //     child: const Text(
                      //       'Testimonial',
                      //       style: TextStyle(
                      //         color: AppColors.blackColor,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: AppFonts.font17,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  provider.coursesList.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (ctx, index) => CoursesListItemWidget(
                            model: provider.coursesList[index],
                          ),
                          itemCount: provider.coursesList.length,
                        )
                      : Container(
                          height: 70.appHeight(context),
                          alignment: Alignment.center,
                          child: provider.getCoursesLoading
                              ? const LoadingWidget()
                              : const EmptyWidget(),
                        ),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemBuilder: (ctx, index) => index == 0
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Courses',
                            style: TextStyle(
                              color: AppColors.blueColor1,
                              fontWeight: FontWeight.w500,
                              fontSize: AppFonts.font20,
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     context.push(
                          //       const TestimonialsScreen(),
                          //     );
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(
                          //         color: AppColors.blueColor1,
                          //       ),
                          //     ),
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 10,
                          //       vertical: 8,
                          //     ),
                          //     alignment: Alignment.center,
                          //     child: const Text(
                          //       'Testimonial',
                          //       style: TextStyle(
                          //         color: AppColors.blackColor,
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: AppFonts.font17,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    : provider.coursesList.isNotEmpty
                        ? CoursesListItemWidget(
                            model: provider.coursesList[index - 1],
                          )
                        : Container(
                            height: 70.appHeight(context),
                            alignment: Alignment.center,
                            child: provider.getCoursesLoading
                                ? const LoadingWidget()
                                : const EmptyWidget(),
                          ),
                separatorBuilder: (ctx, index) => const SizedBox(
                  height: 25,
                ),
                itemCount: provider.coursesList.isNotEmpty
                    ? provider.coursesList.length + 1
                    : 2,
              ),
      );
    });
  }
}
