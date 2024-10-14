class NotesModel {
  NotesModel({
    required this.content,
    required this.image,
    required this.id,
  });

  NotesModel.fromJson(dynamic json) {
    content = json['content'] ?? '';
    image = json['image'] ?? '';
    id = json['id'] ?? 0;
  }

  late String content;
  late String image;
  late int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['image'] = image;
    map['id'] = id;
    return map;
  }
}
