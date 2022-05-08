import 'package:e_commerce/layout/shop_app/cateogries/categories_screen.dart';
import 'package:e_commerce/layout/shop_app/cubit/states.dart';
import 'package:e_commerce/layout/shop_app/favorites/favorites_screen.dart';
import 'package:e_commerce/layout/shop_app/products/products_screen.dart';
import 'package:e_commerce/layout/shop_app/settings/settings_screen.dart';
import 'package:e_commerce/models/shop_app/Categories_model/Categories_model.dart';
import 'package:e_commerce/models/shop_app/Favories_model/Favories_model.dart';
import 'package:e_commerce/models/shop_app/Favories_model/change_Favories_model.dart';
import 'package:e_commerce/models/shop_app/Home_model/home_model.dart';
import 'package:e_commerce/models/shop_app/login_model/login_model.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/network/end_point.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int Index) {
    currentIndex = Index;
    emit(ShopChangeBottomNavBar());
  }

  HomeModel? homeModel;

  Map<int ,bool> favorites={};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({                             //مع كل لفه نحط في المفضله قيمه
          element['id']:element['in_favorites'],
        });
      });
      print(favorites.toString());


      //print(favorites.toString());

      // print(homeModel?.data?.banners[0].image);
      // print(homeModel?.status);
      //printFullText(homeModel.toString());

      emit(ShopSuccessHomeDataStates());

    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesModel() {

    DioHelper.getData(

      url: GET_CATEGORIES,             //end_point
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesStates());

    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesmodel? changeFavoritesmodel;

  void changeFavorites(int productId){
    favorites[productId]=!favorites[productId]!;    //قبل ما ادخل علشان تنور بسرعه

    emit(ShopChangeFavoritesStates());   //علشان تنور

    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productId,
        },
       token: token,
    ).then((value) {
      changeFavoritesmodel = ChangeFavoritesmodel.fromjson(value.data);
      print(value.data);
      if(!changeFavoritesmodel!.status!){
        favorites[productId]=!favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesmodel!));

    }).catchError((error){
      favorites[productId]=!favorites[productId]!;

      emit(ShopErrorChangeFavoritesStates());
      });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getData(

      url: FAVORITES,             //end_point
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.toString());

      emit(ShopSuccessGetFavoritesStates());

    }).catchError((error) {
      print(error.toString());

      emit(ShopErorrGetFavoritesStates());
    });
  }


  ShopLoginModel? UserData;

  void getUserData() {
    emit(ShopLoadingUserDataStates());

    DioHelper.getData(

      url:PROFILE ,             //end_point
      token: token,

    ).then((value) {
      UserData = ShopLoginModel.fromJson(value.data);
      //print(value.toString());

      emit(ShopSuccessUserDataStates(UserData!));

    }).catchError((error) {
      print(error.toString());

      emit(ShopErorrUserDataStates());
    });
  }


  ShopLoginModel? userModel;

  void getUpdateData({
  @required String? name,
    @required String? email,
    @required String? phone,
})
{
    emit(ShopLoadingUpdateUserStates());

    DioHelper.putData(

      url:UPDATE_PROFILE ,             //end_point
      token: token,
      data:{
        'name':name,
        'email':email,
        'phone':phone,
      },

    ).then((value) {
      UserData = ShopLoginModel.fromJson(value.data);
      //print(value.toString());

      emit(ShopSuccessUpdateUserStates(UserData!));

    }).catchError((error) {
      print(error.toString());

      emit(ShopErorrUpdateUserStates());
    });
  }


}
