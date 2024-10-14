
class SectionModel {
  SectionModel({
    required this.id,
    required this.title,
    required this.haveSections,
    required this.haveContent,
  });

  SectionModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    haveSections = json['have_sections'] ?? false;
    haveContent = json['have_content'] ?? false;
  }

  late int id;
  late String title;
  late bool haveSections;
  late bool haveContent;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['have_sections'] = haveSections;
    map['have_content'] = haveContent;
    return map;
  }
}
