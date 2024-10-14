class BookModel{

  /*
      {
            "title": "database book",
            "pdf": "https://desk-course.softwareconnecteg.com/public/uploads/courses/books/1691153780.pdf"
        }
   */

  late String title;
  late String pdf;

  BookModel.fromJson(dynamic json){
    title = json['title']??'';
    pdf = json['pdf']??'';
  }

}