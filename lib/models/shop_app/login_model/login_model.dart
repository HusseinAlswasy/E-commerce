class ShopLoginModel{
  bool? status;
  String? message;
  UserData? data;


ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null? UserData.fromJson(json['data']):null;   //اعمل حسابي ان داتا ممكن متجيش ليك

  }

}
class UserData{
  int?  id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  dynamic credit;
  String? token;

  UserData.fromJson(Map<String,dynamic> json)        //داتا االلي بتيجي
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];


  }

//   UserData({
//    this.id,
//    this.name,
//    this.email,
//    this.phone,
//    this.image,
//    this.points,
//     this.credit,
//     this.token,
// });

  //named constructor

}