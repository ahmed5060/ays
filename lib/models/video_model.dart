class VideoModel {
  VideoModel({
    required this.name,
    required this.description,
    required this.video,
  });

  VideoModel.fromJson(dynamic json) {
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    video = json['video'] ?? '';
  }

  late String name;
  late String description;
  late String video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['video'] = video;
    return map;
  }
}
