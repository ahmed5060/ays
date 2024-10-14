import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:flutter/material.dart';
import '../core/helper/api_helper.dart';
import '../models/testimonials_model.dart';

class TestimonialsProvider extends ChangeNotifier {
  List<TestimonialsModel> testimonialsList = [];

  bool getTestimonialsLoading = false;

  Future<void> getTestimonials() async {
    getTestimonialsLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: EndPoints.getTestimonials,
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        testimonialsList = [];
        response.data['data'].forEach((item) {
          testimonialsList.add(
            TestimonialsModel.fromJson(
              item,
            ),
          );
        });
      }
    }

    getTestimonialsLoading = false;
    notifyListeners();
  }

  Future<void> addTestimonial(
    String description,
    int rate,
  ) async {
    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.addTestimonials,
      apiBody: {
        'description': description,
        'rate': rate,
      },
    );

    if (response.success) {
      testimonialsList.add(
        TestimonialsModel(
          date:
              '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
          description: description,
          rate: rate,
          id: 0,
        ),
      );
      notifyListeners();
    }
  }

  Future<void> updateTestimonial(
    TestimonialsModel model,
  ) async {
    for (var element in testimonialsList) {
      if (element.id == model.id) {
        element.description = model.description;
        element.rate = model.rate;
        break;
      }
    }
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.updateTestimonials,
      isMain: false,
      apiBody: {
        "testimonial_id": model.id,
        "description": model.description,
        "rate": model.rate,
      },
    );

    if (response.success) {
      notifyListeners();
    }
  }
}
