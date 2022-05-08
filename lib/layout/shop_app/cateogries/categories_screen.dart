import 'package:e_commerce/layout/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/Categories_model/Categories_model.dart';
import 'package:e_commerce/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) => {},
      builder: (context,state){
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context,index)=> Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey.shade100,
            ),
          ),
          itemBuilder:(context,index) => buildCategory(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }
}

Widget buildCategory(model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:[
          Image(
            image: NetworkImage(model.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20,
              color: deafultcolor,
            ),
          ),
          Spacer(),
          const Icon(
              Icons.arrow_forward_ios_rounded,
            color: deafultcolor,
          ),
        ],
      ),
    );
