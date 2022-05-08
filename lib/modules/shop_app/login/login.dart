import 'package:e_commerce/layout/shop_app/Shop_Layout.dart';
import 'package:e_commerce/modules/shop_app/Singup/SingUp.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/cubit.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/state.dart';
import 'package:e_commerce/shared/componenets/componentes.dart';
import 'package:e_commerce/shared/componenets/constent.dart';
import 'package:e_commerce/shared/network/local/chahe_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopAppLogin extends StatelessWidget {
  var formKey = GlobalKey<FormState>(); //validation
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token',
                  value: state.loginModel.data!.token,
              ).then((value) {

                token =state.loginModel.data!.token;

                navigateAndFinish(
                        context, ShopLayout(),
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
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      const Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        height: size.height * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: deafultTextFromFeiled(
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          onSubmit: (value) {},
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email ';
                            }
                          },
                          label: "Email",
                          hint: "Email",
                          prefix: Icons.email_rounded,
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
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword:
                              ShopLoginCubit.get(context).isPasswordShow,
                          SuffixPressed: () {
                            ShopLoginCubit.get(context)
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
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => deafultButton(
                          text: "LOGIN",
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
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
                                  builder: (context) => SingUp()));
                        },
                        child: const Text(
                          "Don\'t have an account? SingUp",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
