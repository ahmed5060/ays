
class MessageModel {
  late String message;
  late String date;
  late String name;
  late MessageType type;
  late int id;

   MessageModel({
    required this.message,
    required this.date,
    required this.name,
    required this.type,
    required this.id,
  });

  MessageModel.fromJson(dynamic json){
    message = json['message']??'';
    date = json['date']??'';
    type = MessageType.text;
    name = json['name']??'';
    id = json['id']??0;
  }

  Map toJson(){
    return {
      'message':message,
      'id':id,
      'name':name,
      'date':date,
      'type':type.name,
    };
  }

}

enum MessageType{
  text,
}
