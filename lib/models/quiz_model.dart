class QuizModel {
  QuizModel(
      {required this.id,
      required this.name,
      required this.examType,
      required this.duration});

  QuizModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    examType = json['exam_type'] == 'mcq'
        ? ExamType.mcq
        : json['exam_type'] == 'shortanswer'
            ? ExamType.shortAnswer
            : ExamType.other;
    duration = json['duration'] ?? '';
  }

  late int id;
  late String name;
  late ExamType examType;
  late int duration;
}

enum ExamType {
  mcq,
  shortAnswer,
  true_false,
  other,
}

class QuizModel2 {
  QuizModel2({
    required this.id,
    required this.name,
    required this.examType,
  });

  QuizModel2.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    examType = json['exam_type'] == 'mcq'
        ? ExamType.mcq
        : json['exam_type'] == 'shortanswer'
            ? ExamType.shortAnswer
            : ExamType.other;
  }

  late int id;
  late String name;
  late ExamType examType;
}
