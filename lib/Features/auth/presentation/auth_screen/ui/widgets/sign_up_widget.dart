import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recogenie/core/Responsive/UiComponents/info_widget.dart';

import '../../../../../../core/helper/FormValidator/validator.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/password_visibility_cubit.dart';
import 'auth_text_field.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {


    String? retypePasswordValidator(String? value) {
      return ValidatorHelper.isPasswordConfirmed(
        context.read<AuthCubit>().passwordController.text,
        value,
      );
    }

    return InfoWidget(builder: (context, deviceInfo) {
      return Form(
          key: _formKey,
          child: Column(
            children: [

              buildAuthTextField(
                deviceInfo: deviceInfo,
                labelTxt: 'Name',
                controller: context.read<AuthCubit>().nameController,
                hintTxt: 'Enter your Name',
                context: context,
                validators: ValidatorHelper.isNotEmpty,
                isPassword: false,
              ),
              SizedBox(height: deviceInfo.screenHeight * 0.01,),

              buildAuthTextField(
                deviceInfo: deviceInfo,
                labelTxt: 'Email',
                controller: context.read<AuthCubit>().emailController,
                hintTxt: 'Enter your email',
                context: context,
                validators: ValidatorHelper.combineValidators([
                  ValidatorHelper.isNotEmpty,
                  ValidatorHelper.isValidEmail
                ]),
                isPassword: false,
              ),

              SizedBox(height: deviceInfo.screenHeight * 0.01,),

              BlocProvider(
                  create: (_) => PasswordVisibilityCubit(),
                  child:BlocBuilder<PasswordVisibilityCubit, bool>(builder: (context, isHidden){
                    return buildAuthTextField(
                      deviceInfo: deviceInfo,
                      controller: context.read<AuthCubit>().passwordController,
                      isPassword: true,
                      labelTxt: 'Password',
                      hintTxt: '***********',
                      isHidden: isHidden,
                      validators: ValidatorHelper.combineValidators([
                        ValidatorHelper.isNotEmpty,
                        ValidatorHelper.isValidPassword
                      ]),
                      context: context,
                    );
                  })
              ),

              SizedBox(height: deviceInfo.screenHeight * 0.01,),

              BlocProvider(
                  create: (_) => PasswordVisibilityCubit(),
                  child:BlocBuilder<PasswordVisibilityCubit, bool>(builder: (context, isHidden){
                    return buildAuthTextField(
                      deviceInfo: deviceInfo,
                      controller: context.read<AuthCubit>().confirmPasswordController,
                      isPassword: true,
                      labelTxt: 'Confirm Password',
                      hintTxt: '***********',
                      isHidden: isHidden,
                      validators: ValidatorHelper.combineValidators([
                        ValidatorHelper.isNotEmpty,
                        retypePasswordValidator
                      ]),
                      context: context,
                    );
                  })
              ),

              SizedBox(height: deviceInfo.screenHeight * 0.03,),

              SizedBox(
                width: deviceInfo.screenWidth * 0.55,
                height: deviceInfo.screenHeight * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.05),
                      )
                  ),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signUp();
                    }

                  },
                  child: context.read<AuthCubit>().state is AuthLoading ? CircularProgressIndicator(color: Colors.white,) : Text('Sign Up',style: TextStyle(fontSize: deviceInfo.screenWidth * 0.04,color: Colors.white),),),
              ),

              SizedBox(height: deviceInfo.screenHeight * 0.01,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account',style: TextStyle(color: Colors.black,fontSize: deviceInfo.screenWidth * 0.04),),
                  TextButton(onPressed: (){
                    context.read<AuthCubit>().changeLoginAndSignUp();
                  }, child: Text('Sign In',style: TextStyle(color: Colors.blueAccent,fontSize: deviceInfo.screenWidth * 0.04),))
                ],
              )
            ],
          ));
    });
  }


}