import 'package:e_commerce/models/shop_app/login_model/login_model.dart';
import 'package:flutter/material.dart';
abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);     //علشان نظهر الايرور علي الاسكرين
}

class ShopLoginChangeIcon extends ShopLoginStates{}


