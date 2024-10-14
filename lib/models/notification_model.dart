class NotificationModel {
  NotificationModel({
    this.message,
    this.course,
  });

  NotificationModel.fromJson(dynamic json) {
    message = json['message'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  String? message;
  Course? course;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (course != null) {
      map['course'] = course?.toJson();
    }
    return map;
  }
}

class Course {
  Course({
    this.courseId,
    this.name,
  });

  Course.fromJson(dynamic json) {
    courseId = json['course_id'];
    name = json['name'];
  }

  int? courseId;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['course_id'] = courseId;
    map['name'] = name;
    return map;
  }
}
