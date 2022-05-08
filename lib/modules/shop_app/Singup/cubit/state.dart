import 'package:e_commerce/models/shop_app/login_model/login_model.dart';
import 'package:flutter/material.dart';
abstract class ShopSingUpStates{}

class ShopSingUpInitialState extends ShopSingUpStates{}

class ShopSingUpLoadingState extends ShopSingUpStates{}

class ShopSingUpSuccessState extends ShopSingUpStates{
  final ShopLoginModel loginModel;

  ShopSingUpSuccessState(this.loginModel);
}

class ShopSingUpErrorState extends ShopSingUpStates{
  final String error;

  ShopSingUpErrorState(this.error);     //علشان نظهر الايرور علي الاسكرين
}

class ShopSingUpChangeIcon extends ShopSingUpStates{}


