import 'dart:io';

import 'package:courses_app/Pdf_section/pdfs_sections_screen.dart';
import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/helper/app_helper.dart';
import 'package:courses_app/models/navigation_model.dart';
import 'package:courses_app/providers/navigation_provider.dart';
import 'package:courses_app/views/ask/ask_screen.dart';
import 'package:courses_app/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../models/course_model.dart';
import '../../../models/message_model.dart';

class CoursesDetailsGridItemWidget extends StatelessWidget {
  const CoursesDetailsGridItemWidget(
      {Key? key, required this.model, required this.courseModel})
      : super(key: key);
  final NavigationModel model;
  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (model.index == 6) {
        //   context.push(
        //     ChatScreen(
        //       model: MessageModel(
        //         id: courseModel.id,
        //         name: courseModel.name,
        //         message: '',
        //         type: MessageType.text,
        //         date: '',
        //       ),
        //     ),
        //   );
        // } else
          if (model.index == 7) {
          await AppHelper.launchToGoogle(
            context
                .read<NavigationProvider>()
                .meetings[courseModel.id]!
                .meetingLink,
          );
        }
        //   else if (model.index == 7) {
        //   context.push(AskScreen(courseModel: courseModel));
        //
        //   // ask
        // }
          else if (model.index == 6) {
          context.push(PdfSectionsScreen(id: courseModel.id));
          //pdf
        } else {
          context.read<NavigationProvider>().changeCurrentIndex(model.index);
        }
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12,
          ),
          child: LayoutBuilder(builder: (context, con) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      model.image,
                      height: con.maxHeight * 0.5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: Platform.isWindows
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        color: AppColors.blueColor1,
                        fontWeight: FontWeight.w500,
                        fontSize: AppFonts.font16,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: con.maxWidth,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor1,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Go To Learn',
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
