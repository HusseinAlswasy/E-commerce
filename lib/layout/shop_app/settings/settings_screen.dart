import 'package:e_commerce/layout/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layout/shop_app/cubit/states.dart';
import 'package:e_commerce/shared/componenets/componentes.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SettingsScreen extends StatelessWidget {
var formKey =GlobalKey<FormState>();
 var nameController = TextEditingController();
 var emailController = TextEditingController();
 var phoneController = TextEditingController();


 SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){
     //    if(state is ShopSuccessUserDataStates){    //متلعبش ع ال stste
     //     /* print(state.loginModel!.data!.name!);
     //      print(state.loginModel!.data!.email!);
     //      print(state.loginModel!.data!.phone!);*/
     //
     // /*     nameController.text = state.loginModel!.data!.name!;
     //      emailController.text = state.loginModel!.data!.email!;
     //      phoneController.text = state.loginModel!.data!.phone!;*/
     //
     //    }
      },
      builder: (context,state){
        var model = ShopCubit.get(context).UserData!;

        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).UserData != null,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key:formKey,
                child: SingleChildScrollView (
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserStates)
                      LinearProgressIndicator(),
                      const SizedBox(height:20,),
                      const Center(
                        child: Text(
                          'Informations',
                          style: TextStyle(
                            fontSize: 24,
                            color: deafultcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height:40,),

                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        onSubmit: (String value){},
                        onChange: (String value){},
                        onTap: (){},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Name Is Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.person,
                      ),
                      const SizedBox(height:20,),

                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        onSubmit: (String value){},
                        onChange: (String value){},
                        onTap: (){},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Email Is Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.email_outlined,
                      ),

                      const SizedBox(height:20,),

                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        onSubmit: (String value){},
                        onChange: (String value){},
                        onTap: (){},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Phone Number Is Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.phone,
                      ),
                      const SizedBox(height:20),

                      deafultButton(
                        text: 'Logout',
                        function: (){
                          singout(context);
                        },
                      ),
                      const SizedBox(height:20),

                      deafultButton(
                        text: 'Update',
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).getUpdateData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                    ],

                  ),
                ),
              ),
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
