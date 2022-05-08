import 'package:e_commerce/layout/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/Favories_model/Favories_model.dart';
import 'package:e_commerce/shared/componenets/componentes.dart';
import 'package:e_commerce/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ConditionalBuilder(
          condition:state is! ShopLoadingGetFavoritesStates,

          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey.shade100,
              ),
            ),
            itemBuilder:(context,index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
            itemCount:ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),

          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildfavoriteItem(model,context)=> Container(
    height: 140,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 140,
                height: 140,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: deafultcolor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice!.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                        // print(model['id']);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id!]! ? deafultcolor:Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 19.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
