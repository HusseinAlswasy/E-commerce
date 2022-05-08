import 'package:e_commerce/layout/shop_app/Shop_Layout.dart';
import 'package:e_commerce/layout/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/cubit/states.dart';
import 'package:e_commerce/layout/shop_app/search/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/search/search_screen.dart';
import 'package:e_commerce/modules/shop_app/Singup/cubit/cubit.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/cubit.dart';
import 'package:e_commerce/modules/shop_app/login/login.dart';
import 'package:e_commerce/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/network/local/chahe_helper.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:e_commerce/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'layout/shop_app/search/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark'); //اقدر اجيب الداتا
  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding'); //اقدر اجيب الداتا

  token = CacheHelper.getData(key: 'token'); //login// token save it  يقدر يتشاف برا علشان عامله سيف في constent
  print(token);

  if (onBoarding != null)
  {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopAppLogin();
  } else {
    widget = OnBoardingScreen();
  }

  print(onBoarding);

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final bool? isDark;

  MyApp({ this.isDark, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesModel()..getFavorites()..getUserData(),
        ),
        BlocProvider(create: (BuildContext context)=> ShopLoginCubit() ),
        BlocProvider(create: (BuildContext context)=> ShopSingUpCubit() ),
        BlocProvider(create: (BuildContext context)=> SearchCubit() ),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder:(context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            //darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
