import 'package:courses_app/core/extension/context_extention.dart';
import 'package:courses_app/main.dart';
import 'package:courses_app/models/section_model.dart';
import 'package:flutter/material.dart';

import '../core/endpoints/end_points.dart';
import '../core/helper/api_helper.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  List<SectionModel> sections = [];
  List<SectionModel> subSections = [];
  List<QuizModel> quizzes = [];
  Map<int, List<QuestionModel>> questions = {};

  bool getQuizzesLoading = false;

  Future<void> getSections({
    int? courseId,
    int? sectionId,
    bool content = false,
  }) async {
    quizzes = [];
    getQuizzesLoading = true;
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
        ? '${EndPoints.getQuizzesSections}$courseId'
        : content
            ? '${EndPoints.getQuizzesContent}$sectionId'
            : '${EndPoints.getQuizzesSubSections}$sectionId');
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: sectionId == null
          ? '${EndPoints.getQuizzesSections}$courseId'
          : content
              ? '${EndPoints.getQuizzesContent}$sectionId'
              : '${EndPoints.getQuizzesSubSections}$sectionId',
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
          quizzes = [];
          response.data['data'].forEach((item) {
            quizzes.add(
              QuizModel.fromJson(
                item,
              ),
            );
          });
        }
        notifyListeners();
      }
    }

    getQuizzesLoading = false;
    notifyListeners();
  }

  bool getQuestionsLoading = false;
  bool isSubmitted = false;
  Future<void> getQuestions(int id) async {
    questions[id] = [];
    getQuestionsLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.getQuizzesQuestions}$id',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        final List<QuestionModel> temp = [];
        response.data['data'].forEach((item) {
          temp.add(
            QuestionModel.fromJson(item),

          );
        });
        questions[id] = temp;
        
        setSelected(questions[id]!.length);
      }
      notifyListeners();
    }

    getQuestionsLoading = false;
    notifyListeners();
  }

  List<String> selectedMCQ = [];

  void setSelected(int count) {
    selectedMCQ = [];

    for (int index = 0; index < count; index++) {
      selectedMCQ.add('');
    }
    notifyListeners();
  }

  void changeSelectedMCQ(int topIndex, String value) {
    selectedMCQ[topIndex] = value;
    notifyListeners();
  }

  bool submitLoading = false;

  Future<void> submit(int id) async {
    submitLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < questions[id]!.length; i++) {
      data.add(
        {
          "question_id": questions[id]![i].id,
          "answer": selectedMCQ[i].isEmpty ? null : selectedMCQ[i],
        },
      );
    }

    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.mark,
      apiBody: {
        "quiz_id": id,
        "data": data,
      },
    );

    if (response.success) {
      setSelected(0);
      questions[id] = [];

      MyApp.navigatorKey.currentContext!.pop();
    }

    submitLoading = false;
    notifyListeners();
  }

  //

  /// T && F
  List selectedTF = [];

  void setSelected2(int count) {
    selectedTF = [];

    for (int index = 0; index < count; index++) {
      selectedTF.add('');
    }
    notifyListeners();
  }

  void changeSelectedTF(int topIndex, int value) {
    selectedTF[topIndex] = value;
    notifyListeners();
  }

  bool submitLoading2 = false;

  Future<void> submit2(int id) async {
    submitLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < questions[id]!.length; i++) {
      data.add(
        {
          "question_id": questions[id]![i].id,
          "answer": selectedTF[i].isEmpty ? null : selectedTF[i],
        },
      );
    }

    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.mark,
      apiBody: {
        "quiz_id": id,
        "data": data,
      },
    );

    if (response.success) {
      setSelected(0);
      questions[id] = [];

      // MyApp.navigatorKey.currentContext!.pop();
    }

    submitLoading = false;
    notifyListeners();
  }
}
