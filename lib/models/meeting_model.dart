class MeetingModel{


  late int id;
  late String meetingLink;
  late String meetingDate;

  MeetingModel.fromJson(dynamic json){
    id = json['id']??0;
    meetingLink = json['meeting_link']??'';
    meetingDate = json['meeting_date']??'';
  }

}