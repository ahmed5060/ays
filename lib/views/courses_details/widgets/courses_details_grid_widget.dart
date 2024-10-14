import 'dart:io';

import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/core/extension/size_extension.dart';
import 'package:courses_app/core/utils/app_colors.dart';
import 'package:courses_app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/course_model.dart';
import '../../../providers/navigation_provider.dart';
import 'courses_details_grid_item_widget.dart';

class CoursesDetailsGridWidget extends StatefulWidget {
  const CoursesDetailsGridWidget({Key? key, required this.courseModel})
      : super(key: key);
  final CourseModel courseModel;

  @override
  State<CoursesDetailsGridWidget> createState() =>
      _CoursesDetailsGridWidgetState();
}

class _CoursesDetailsGridWidgetState extends State<CoursesDetailsGridWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context
          .read<NavigationProvider>()
          .courseMeeting(widget.courseModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<NavigationProvider>(builder: (context, provider, _) {
        return ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isWindows ? 40 : 20,
              ),
              child: Text(
                widget.courseModel.name,
                style: const TextStyle(
                  color: AppColors.blueColor1,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFonts.font20,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Platform.isWindows ? 3 : 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: Platform.isWindows ? 1.5 : 0.8,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isWindows ? 40 : 20,
                vertical: 5,
              ),
              itemBuilder: (ctx, index) => CoursesDetailsGridItemWidget(
                model: provider.homeTapsList[index],
                courseModel: widget.courseModel,
              ),
              itemCount: Platform.isWindows
                  ? provider.meetings[widget.courseModel.id] != null
                      ? 5
                      : 4
                  : provider.meetings[widget.courseModel.id] != null
                      ? 7
                      : 6,
            ),
            if (Platform.isWindows)
              const SizedBox(
                height: 25,
              ),
            if (Platform.isWindows)
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 50.appWidth(context),
                  margin:
                      EdgeInsets.symmetric(horizontal: 25.appWidth(context)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor1,
                  ),
                  child: const Text(
                    'Back To Your Courses',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.font16,
                    ),
                  ),
                ),
              ),
            if (Platform.isWindows)
              const SizedBox(
                height: 25,
              ),
          ],
        );
      }),
    );
  }
}
