class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.nationality,
    required this.speciality,
    required this.examDate,
    required this.active,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    image = json['image'] ?? '';
    nationality = json['nationality'] ?? '';
    speciality = json['speciality'] ?? '';
    examDate = json['exam_date'] ?? '';
    active = json['active'] ?? 0;
    emailVerifiedAt = json['email_verified_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    code = json['code'] ?? '';
  }

  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String nationality;
  late String speciality;
  late String examDate;
  late int active;
  late String emailVerifiedAt;
  late String createdAt;
  late String updatedAt;
  late String code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['nationality'] = nationality;
    map['speciality'] = speciality;
    map['exam_date'] = examDate;
    map['active'] = active;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
      map['code'] = code;
    return map;
  }
}
