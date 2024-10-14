import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:courses_app/core/utils/app_images.dart';
import 'package:courses_app/models/book_model.dart';
import 'package:flutter/material.dart';

import '../../core/shared/main_app_bar_widget.dart';
import '../pdf/pdf_viewer_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key, required this.model}) : super(key: key);
  final BookModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: model.title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: Platform.isWindows
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.push(
                  PdfViewerWidget(
                    url: model.pdf,
                  ),
                );
              },
              child: SizedBox(
                height: 30.appHeight(context),
                width: Platform.isWindows
                    ? 50.appWidth(context)
                    : 100.appWidth(context) - 40,
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Image.asset(
                        AppImages.testBook2,
                        scale: 1.2,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(),
                          const SizedBox(),
                          Text(
                            model.title,
                            style: const TextStyle(
                              color: AppColors.blueColor1,
                              fontWeight: FontWeight.w500,
                              fontSize: AppFonts.font22,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.calenderGrey,
                                height: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                                style: const TextStyle(
                                  color: AppColors.greyColor1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppFonts.font12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.blueColor1,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Open Book',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppFonts.font12,
                                  ),
                                ),
                                SizedBox(),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
