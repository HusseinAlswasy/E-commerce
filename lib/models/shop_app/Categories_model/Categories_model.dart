import 'package:e_commerce/main.dart';

class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){  //named constructor

    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  List data=[];
   int? current_page;

  CategoriesDataModel.fromJson(Map<String,dynamic> json){

    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });

  }

}

class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic> json){

    id = json['id'];
    name = json['name'];
    image = json['image'];

  }
}