class TestimonialsModel {
   TestimonialsModel({
      required this.date,
      required this.description,
      required this.rate,
   required this.id,
   });

  TestimonialsModel.fromJson(dynamic json) {
    date = json['date']??'';
    description = json['description']??'';
    rate = json['rate']??0;
    id = json['id']??0;
  }
  late String date;
  late String description;
  late int rate;
  late int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['description'] = description;
    map['rate'] = rate;
    map['id'] = id;
    return map;
  }

}