import 'package:bingebox/constants/color.dart';
import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/constants/custom_button_widget.dart';
import 'package:bingebox/constants/defaultFormField.dart';
import 'package:bingebox/constants/width_and_height.dart';
import 'package:bingebox/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit=bingeboxCubit.get(context);
    return BlocConsumer<bingeboxCubit, bingeboxStates>(
      listener: (BuildContext context, bingeboxStates state) {
        // if (state is LoginErrorState) {
        //   AwesomeDialog(
        //     context: context,
        //     dialogType: DialogType.error,
        //     headerAnimationLoop: true,
        //     animType: AnimType.bottomSlide,
        //     title: 'Error',
        //     reverseBtnOrder: true,
        //     desc: 'The email or password is incorrect',
        //   ).show();
        // }
        // if (state is LoginSuccessState) {
        //   CacheHelper.setData(
        //     key: 'uId',
        //     value: state.uId,
        //   ).then((value) {
        //     // Navigator.pushReplacement(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) => const HomeLayout(),
        //     //   ),
        //     // );
        //   });
        // }
      },
      builder: (BuildContext context, bingeboxStates state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor:backgroundColor,
            foregroundColor: Colors.white,
            title:const SizedBox(height: 50,
                child: Image(image: AssetImage('assets/logo2.png'),)),
          ),
          body: ModalProgressHUD(
            inAsyncCall: bingeboxCubit.get(context).showSpin,
            child: Form(
              key: cubit.formKey,
              child: SizedBox(
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    const Text(
                      'Create Account',
                      textAlign:TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: height(context)*0.08,),
                    defaultFormField(
                        controller: cubit.email,
                        tybe: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty ';
                          }
                          return null;
                        },
                        text: 'Enter your email',
                        width: width(context)*0.9,
                        pref: Icons.email,
                        radius: 10

                    ),
                    SizedBox(height: height(context)*0.03,),
                    defaultFormField(
                      controller: cubit.password,
                      tybe: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty ';
                        }
                        return null;
                      },
                      text: 'Enter your password',
                      width: width(context)*0.9,
                      pref: Icons.lock,
                      radius: 10,
                      isPassword:true,
                    ),
                    SizedBox(height: height(context)*0.03,),
                    defaultFormField(
                      controller: cubit.password,
                      tybe: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty ';
                        }
                        return null;
                      },
                      text: 'Config your password',
                      width: width(context)*0.9,
                      pref: Icons.lock,
                      radius: 10,
                      isPassword:true,
                    ),
                    SizedBox(height: height(context)*0.05,),
                    CustomButtonWidget(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                      borderRadius: 10,
                      text: 'Sign Up',
                      heightButton: height(context)*0.06,
                      widthButton: width(context)*0.9,
                    ),
                  ],
                ),

              ),
            ),
          ),
        );
      },
    );
  }
}