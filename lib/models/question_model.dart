class QuestionModel {
  QuestionModel({
    required this.id,
    required this.questionType,
    required this.question,
    required this.answer,
    required this.answers,
    required this.rightAnswer,
    required this.grade,
    this.submitted,
  });

  QuestionModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    questionType = json['question_type'] == 'text'
        ? QuestionType.text
        : json['question_type'] == 'photo'
            ? QuestionType.photo
            : QuestionType.other;
    question = json['question'] ?? '';
    answer = json['answer'] ?? '';
    answers = [];
    if (json['answers'] is Map) {
      json['answers'].forEach((key, value) {
        answers.add(value.toString());
      });
    }
    rightAnswer = json['right_answer'] ?? '';
    grade = json['grade'] ?? 0;
    submitted = json['submitted'];
  }

  late int id;
  late QuestionType questionType;
  late String question;
  late String answer;
  late List<String> answers;
  late String rightAnswer;
  late int grade;
  bool? submitted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question_type'] = questionType;
    map['question'] = question;
    map['answer'] = answer;
    map['answers'] = answers;
    map['right_answer'] = rightAnswer;
    map['grade'] = grade;
    map['submitted'] = submitted;

    return map;
  }
}

enum QuestionType {
  text,
  photo,
  other,
}

// class QuestionModel {
//   QuestionModel({
//     required this.id,
//     required this.questionType,
//     required this.question,
//     // required this.answer,
//     required this.answers,
//     required this.rightAnswer,
//   });

//   QuestionModel.fromJson(dynamic json) {
//     id = json['id'] ?? 0;
//     questionType = json['question_type'] == 'text'
//         ? QuestionType.text
//         : json['question_type'] == 'photo'
//             ? QuestionType.photo
//             : QuestionType.other;
//     question = json['question'] ?? '';
//     // answer = json['answer'] ?? '';
//     answers = [];
//     if (json['answers'] is Map) {
//       json['answers'].forEach((key, value) {
//         answers.add(value.toString());
//       });
//     }
//     rightAnswer = json['right_answer'] ?? '';
//     // grade = json['grade'] ?? 0;
//     // submitted = json['submitted'];
//   }

//   late int id;
//   late QuestionType questionType;
//   late String question;
//   //late String answer;
//   late List<String> answers;
//   late String rightAnswer;
//   // late int grade;
//   // late bool submitted;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['question_type'] = questionType;
//     map['question'] = question;
//     //  map['answer'] = answer;
//     map['answers'] = answers;
//     map['right_answer'] = rightAnswer;
//     // map['grade'] = grade;
//     // map['submitted'] = submitted;

//     return map;
//   }
// }
