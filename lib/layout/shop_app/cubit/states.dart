import 'package:e_commerce/models/shop_app/Favories_model/change_Favories_model.dart';
import 'package:e_commerce/models/shop_app/login_model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBar extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErrorCategoriesStates extends ShopStates{}

class ShopChangeFavoritesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{

  final ChangeFavoritesmodel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopErorrGetFavoritesStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{

  final ShopLoginModel? loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopErorrUserDataStates extends ShopStates{}

class ShopSuccessUpdateUserStates extends ShopStates{

  final ShopLoginModel? loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}

class ShopLoadingUpdateUserStates extends ShopStates{}

class ShopErorrUpdateUserStates extends ShopStates{}