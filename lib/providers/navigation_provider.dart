import 'package:courses_app/core/helper/api_helper.dart';

import '../core/endpoints/end_points.dart';
import '../core/utils/app_images.dart';
import '../models/meeting_model.dart';

import 'package:flutter/material.dart';

import '../models/navigation_model.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.play_arrow_outlined,
      ),
      label: 'Videos',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.book_outlined,
      ),
      label: 'Books',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.list_alt_sharp,
      ),
      label: 'Quizzes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.copy,
      ),
      label: 'T-Quizzes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.note_alt_outlined,
      ),
      label: 'Notes',
    ),
  ];

  List<NavigationModel> homeTapsList = [
    NavigationModel(
      name: 'Videos',
      image: AppImages.videos,
      index: 1,
    ),
    NavigationModel(
      name: 'Books',
      image: AppImages.books,
      index: 2,
    ),
    NavigationModel(
      name: 'Quizzes',
      image: AppImages.quiz,
      index: 3,
    ),
    NavigationModel(
      name: 'Training Quiz',
      image: AppImages.pdf,
      index: 4,
    ),
    NavigationModel(
      name: 'Notes',
      image: AppImages.notes,
      index: 5,
    ),
    // NavigationModel(
    //   name: 'Chat',
    //   image: AppImages.chat,
    //   index: 6,
    // ),
    // NavigationModel(
    //   name: 'Ask',
    //   image: AppImages.chat,
    //   index: 7,
    // ),
    NavigationModel(
      name: 'Pdf',
      image: AppImages.pdfNew,
      index: 6,
    ),
    NavigationModel(
      name: 'Meeting',
      image: AppImages.meeting,
      index: 7,
    ),
  ];

  Map<int, MeetingModel> meetings = {};

  Future<void> courseMeeting(int id) async {
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.meeting}$id',
      isMain: false,
    );

    if (response.success) {
      if (response.data != null && response.data['data'] is Map) {
        meetings[id] = MeetingModel.fromJson(response.data['data']);
        notifyListeners();
      }
    }
  }
}
