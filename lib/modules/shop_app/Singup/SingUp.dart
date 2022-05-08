import 'package:e_commerce/modules/shop_app/Singup/cubit/cubit.dart';
import 'package:e_commerce/modules/shop_app/Singup/cubit/state.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/network/local/chahe_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/modules/shop_app/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce/shared/componenets/componentes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../layout/shop_app/Shop_Layout.dart';

class SingUp extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => ShopSingUpCubit(),
      child: BlocConsumer<ShopSingUpCubit, ShopSingUpStates>(
        listener: (context, state) {
          if (state is ShopSingUpSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //const SizedBox(height: 100,),
                    const Center(
                        // child: Text(
                        //   "SingUp",
                        //   style: TextStyle(
                        //     color: Colors.deepPurple,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //   ),
                        // ),
                        ),
                    const SizedBox(
                      height: 60,
                    ),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your name ';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your email ';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: deafultTextFromFeiled(
                        controller: passwordController,
                        keyboard: TextInputType.visiblePassword,
                        suffix: ShopSingUpCubit.get(context).suffix,
                        onSubmit: (value) {},
                        isPassword: ShopSingUpCubit.get(context).isPasswordShow,
                        SuffixPressed: () {
                          ShopSingUpCubit.get(context)
                              .ChangePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is to short';
                          }
                        },
                        label: "password",
                        hint: "password",
                        prefix: Icons.lock,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your phone ';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          hintText: 'Phone',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.deepPurple,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopSingUpLoadingState,
                      builder: (context) => deafultButton(
                        text: "SingUp",
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopSingUpCubit.get(context).userSingUp(
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                              name: nameController.text,
                            );
                          }
                        },
                        width: 300,
                      ),
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      )),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopAppLogin()));
                      },
                      child: const Text(
                        "You have account ? Login",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: .3, color: Colors.deepPurple),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset("assets/icons/facebook.svg",
                                width: 20, height: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: .3, color: Colors.deepPurple),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/google-plus.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: .3, color: Colors.deepPurple),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/twitter.svg",
                              width: 10,
                              height: 20,
                            ),
                          ),
                        ],
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
