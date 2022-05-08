import 'package:e_commerce/models/shop_app/login_model/login_model.dart';
import 'package:e_commerce/modules/shop_app/Singup/cubit/state.dart';
import 'package:e_commerce/shared/network/end_point.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/state.dart';

class ShopSingUpCubit extends Cubit<ShopSingUpStates> {
  ShopSingUpCubit() : super(ShopSingUpInitialState());
  static ShopSingUpCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userSingUp({
    required String email,
    required String password,
    required String name,
    required String phone,

  })
  {

    emit(ShopSingUpLoadingState());
    DioHelper.postData(
        url: REGISTER,            //end point علشان كل شويه مش اناديها
        data: {
          'name': name,           //اخدهم من المدخل
          'email': email,           //اخدهم من المدخل
          'password': password,
          'phone': phone,           //اخدهم من المدخل
        },
        ).then((value) {
          print(value.data);
         loginModel = ShopLoginModel.fromJson(value.data);
         emit(ShopSingUpSuccessState(loginModel!));
          print(loginModel?.data?.id);
    }).catchError((error){
      emit(ShopSingUpErrorState(error.toString()));
    });
  }
 IconData suffix = Icons.remove_red_eye_rounded;
  bool isPasswordShow=true;
  void ChangePasswordVisibility(){
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ?Icons.remove_red_eye_rounded:Icons.visibility_off_rounded;
    emit(ShopSingUpChangeIcon());
  }
}
