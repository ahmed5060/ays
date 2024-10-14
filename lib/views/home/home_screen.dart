import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../courses/widgets/top_bar_info_widget.dart';
import '../courses_details/widgets/courses_details_grid_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.courseModel}) : super(key: key);
  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBarInfoWidget(
          showNotification: false,
        ),
        const SizedBox(
          height: 20,
        ),
        CoursesDetailsGridWidget(
          courseModel: courseModel,
        ),
      ],
    );
  }
}
