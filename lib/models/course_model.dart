class CourseModel {
  CourseModel({
      required this.id,
      required this.name,
      required this.image,
      required this.allowed,
      required this.description,
  });

  CourseModel.fromJson(dynamic json) {
    id = json['id']??0;
    name = json['name']??'';
    image = json['image']??'';
    description = json['description']??'';
    allowed = json['allowed']??false;
  }
  late int id;
  late String name;
  late String image;
  late bool allowed;
  late String description;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['allowed'] = allowed;
    map['description'] = description;
    return map;
  }

}