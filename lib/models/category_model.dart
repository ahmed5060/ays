
class CategoryModel{

  late int id;
  late String name;

  CategoryModel.fromJson(dynamic json){

    id= json['id']??0;
    name= json['name']??'';

  }

}