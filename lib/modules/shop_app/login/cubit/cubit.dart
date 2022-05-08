import 'package:e_commerce/models/shop_app/login_model/login_model.dart';
import 'package:e_commerce/shared/network/end_point.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
})
  {

    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,            //end point علشان كل شويه مش اناديها
        data: {
          'email': email,           //اخدهم من المدخل
          'password': password,
        },
        ).then((value) {
          print(value.data);
         loginModel = ShopLoginModel.fromJson(value.data);
         emit(ShopLoginSuccessState(loginModel!));
          print(loginModel?.data?.id);
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }
 IconData suffix = Icons.remove_red_eye_rounded;
  bool isPasswordShow=true;
  void ChangePasswordVisibility(){
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ?Icons.remove_red_eye_rounded:Icons.visibility_off_rounded;
    emit(ShopLoginChangeIcon());
  }
}
