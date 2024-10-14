import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:courses_app/models/section_model.dart';
import 'package:flutter/material.dart';

import '../models/video_model.dart';

class VideosProvider extends ChangeNotifier {
  List<SectionModel> sections = [];
  List<SectionModel> subSections = [];
  List<VideoModel> videos = [];

  bool getVideosLoading = false;

  Future<void> getSections({
    int? courseId,
    int? sectionId,
    bool content = false,
  }) async {
    getVideosLoading = true;
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
        ? '${EndPoints.getVideosSections}$courseId'
        : content
            ? '${EndPoints.getVideosContent}$sectionId'
            : '${EndPoints.getVideosSubSections}$sectionId');
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: sectionId == null
          ? '${EndPoints.getVideosSections}$courseId'
          : content
              ? '${EndPoints.getVideosContent}$sectionId'
              : '${EndPoints.getVideosSubSections}$sectionId',
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
          videos = [];
          response.data['data'].forEach((item) {
            videos.add(
              VideoModel.fromJson(
                item,
              ),
            );
          });
        }
        notifyListeners();
      }
    }

    getVideosLoading = false;
    notifyListeners();
  }

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  int playerCurrentIndex = 0;

  void changePlayerCurrentIndex(int index) {
    playerCurrentIndex = index;
    notifyListeners();
  }
}
