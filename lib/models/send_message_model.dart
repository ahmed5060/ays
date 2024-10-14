
import 'message_model.dart';

class SendMessageModel {
  late String message;
  late String date;
  late String name;
  late MessageType type;
  late int id;

  SendMessageModel({
    required this.message,
    required this.date,
    required this.name,
    required this.type,
    required this.id,
  });

  SendMessageModel.fromJson(dynamic json){
    message = json['message']??'';
    date = json['date']??'';
    name = json['name']??'';
    type = MessageType.text;
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
