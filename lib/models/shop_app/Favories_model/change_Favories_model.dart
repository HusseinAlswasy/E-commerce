class ChangeFavoritesmodel{
  bool? status;
  String? message;

  ChangeFavoritesmodel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    message =json['message'];
  }
}