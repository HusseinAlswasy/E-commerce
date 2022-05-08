import 'package:e_commerce/layout/shop_app/search/cubit/states.dart';
import 'package:e_commerce/models/shop_app/Search_model/Search_model.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/network/end_point.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) =>BlocProvider.of(context);

  SearchModel? model;

  void search(String? text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
      'text':text,
    },).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}