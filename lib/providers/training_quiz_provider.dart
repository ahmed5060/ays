import 'package:courses_app/models/section_model.dart';
import 'package:courses_app/models/question_model.dart';
import 'package:flutter/material.dart';

import '../core/endpoints/end_points.dart';
import '../core/helper/api_helper.dart';
import '../models/quiz_model.dart';

class TrainingQuizProvider extends ChangeNotifier {
  List<SectionModel> sections = [];
  List<SectionModel> subSections = [];
  List<QuizModel2> trainingQuizzes = [];
  Map<int, List<QuestionModel>> trainingQuestions = {};

  bool getTrainingQuizzesLoading = false;

  Future<void> getSections({
    int? courseId,
    int? sectionId,
    bool content = false,
  }) async {
    trainingQuizzes = [];

    getTrainingQuizzesLoading = true;
    notifyListeners();
    if (sectionId != null) {
      subSections = [];
      notifyListeners();
    }

    debugPrint(sectionId == null
        ? '${EndPoints.getTrainingQuizzesSections}$courseId'
        : content
            ? '${EndPoints.getTrainingQuizzesContent}$sectionId'
            : '${EndPoints.getTrainingQuizzesSubSections}$sectionId');
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: sectionId == null
          ? '${EndPoints.getTrainingQuizzesSections}$courseId'
          : content
              ? '${EndPoints.getTrainingQuizzesContent}$sectionId'
              : '${EndPoints.getTrainingQuizzesSubSections}$sectionId',
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
          trainingQuizzes = [];
          response.data['data'].forEach((item) {
            trainingQuizzes.add(
              QuizModel2.fromJson(
                item,
              ),
            );
          });
        }
        notifyListeners();
      }
    }

    getTrainingQuizzesLoading = false;
    notifyListeners();
  }

  bool getQuestionsLoading = false;

  Future<void> getQuestions(int id) async {
    getQuestionsLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.getTrainingQuizzesQuestions}$id',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        trainingQuestions[id] = [];
        final List<QuestionModel> temp = [];
        response.data['data'].forEach((item) {
          temp.add(
            QuestionModel.fromJson(item),
          );
        });
        trainingQuestions[id] = temp;
      }
      notifyListeners();
    }

    getQuestionsLoading = false;
    notifyListeners();
  }

  List<String> selectedMCQ = [
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
    '-1',
  ];

  void changeSelectedMCQ(int topIndex, String value) {
    selectedMCQ[topIndex] = value;
    notifyListeners();
  }

  bool submit = false;

  void resetSubmit(bool value) {
    submit = value;
    if (!submit) {
      selectedMCQ = [
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
        '-1',
      ];
    }
    notifyListeners();
  }
}
