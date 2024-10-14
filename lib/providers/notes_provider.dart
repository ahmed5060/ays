import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:flutter/material.dart';
import '../core/helper/api_helper.dart';
import '../models/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  Map<int, List<NotesModel>> notesList = {};

  bool getNotesLoading = false;

  Future<void> getNotes(int id) async {
    getNotesLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.getNotes}$id',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        final List<NotesModel> temp = [];
        notesList[id] = [];
        response.data['data'].forEach((item) {
          temp.add(
            NotesModel.fromJson(
              item,
            ),
          );
        });
        notesList[id]!.addAll(temp);
      }
    }

    getNotesLoading = false;
    notifyListeners();
  }

  Future<void> addNote(String content, int id) async {
    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.addNotes,
      apiBody: {
        'note': content,
        'course_id': id,
      },
    );

    if (response.success) {
      if (notesList[id] != null) {
        notesList[id]!.add(
          NotesModel(
            content: content,
            image: '',
            id: 0,
          ),
        );
      } else {
        notesList[id] = [];
        notesList[id]!.add(
          NotesModel(
            content: content,
            image: '',
            id: 0,
          ),
        );
      }

      notifyListeners();
    }
  }

  Future<void> updateNote(NotesModel model, int courseId) async {
    for (var element in notesList[courseId]!) {
      if (element.id == model.id) {
        element.content = model.content;
        break;
      }
    }
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.updateNotes,
      isMain: false,
      apiBody: {
        "note": model.content,
        "course_id": courseId,
        "note_id": model.id,
      },
    );

    if (response.success) {
      notifyListeners();
    }
  }
}
