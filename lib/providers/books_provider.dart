import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:courses_app/models/book_model.dart';
import 'package:courses_app/models/section_model.dart';
import 'package:flutter/material.dart';

class BooksProvider extends ChangeNotifier {
  List<SectionModel> sections = [];
  List<SectionModel> subSections = [];
  List<BookModel> books = [];

  bool getBooksLoading = false;

  Future<void> getSections({
    int? courseId,
    int? sectionId,
    bool content = false,
  }) async {
    getBooksLoading = true;
    notifyListeners();
    if (sectionId != null) {
      subSections = [];
      notifyListeners();
    }
    if (courseId != null) {
      sections = [];
      notifyListeners();
    }
debugPrint(sectionId == null
    ? '${EndPoints.getBooksSections}$courseId'
    : content
    ? '${EndPoints.getBooksContent}$sectionId'
    : '${EndPoints.getBooksSubSections}$sectionId');
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: sectionId == null
          ? '${EndPoints.getBooksSections}$courseId'
          : content
              ? '${EndPoints.getBooksContent}$sectionId'
              : '${EndPoints.getBooksSubSections}$sectionId',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        if (courseId != null) {
          sections = [];
          response.data['data'].forEach((item) {
            sections.add(
              SectionModel.fromJson(
                item,
              ),
            );
          });
        } else if (!content) {
          subSections = [];
          response.data['data'].forEach((item) {
            subSections.add(
              SectionModel.fromJson(
                item,
              ),
            );
          });
        } else {
          books = [];
          response.data['data'].forEach((item) {
            books.add(
              BookModel.fromJson(
                item,
              ),
            );
          });
        }
        notifyListeners();
      }
    }

    getBooksLoading = false;
    notifyListeners();
  }
}
