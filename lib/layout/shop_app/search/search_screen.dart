
import 'package:e_commerce/layout/shop_app/search/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/search/cubit/states.dart';
import 'package:e_commerce/shared/componenets/componentes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

        return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      hint: 'Search',
                      onChange: (String? text) {},
                      onSubmit: (String? text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                      onTap: () {},
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Text to Search';
                        }
                        return null;
                      },
                      prefix: Icons.search,
                    ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context,index)=> Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 1.0,
                            width: double.infinity,
                            color: Colors.grey.shade100,
                          ),
                        ),
                        itemBuilder:(context,index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                        itemCount:SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
