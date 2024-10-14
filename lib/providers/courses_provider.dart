import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';

class CoursesProvider extends ChangeNotifier {
  bool getCoursesLoading = false;

  List<CourseModel> coursesList = [];

  Future<void> getCourses() async {
    getCoursesLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: EndPoints.getCourses,
    );
    if (response.success) {
      if (response.data['data'] != null) {
        coursesList = [];
        response.data['data'].forEach((item) {
          coursesList.add(CourseModel.fromJson(item));
        });
        notifyListeners();
      }
    }
    getCoursesLoading = false;
    notifyListeners();
  }
}
