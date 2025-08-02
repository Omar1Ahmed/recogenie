import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recogenie/Features/auth/presentation/auth_screen/logic/auth_cubit.dart';
import 'package:recogenie/Features/auth/presentation/auth_screen/ui/widgets/sign_in_widget.dart';
import 'package:recogenie/Features/auth/presentation/auth_screen/ui/widgets/sign_up_widget.dart';
import 'package:recogenie/Features/cart/presentation/cart_screen/logic/cart_cubit.dart';
import 'package:recogenie/core/di/injection.dart';
import 'package:recogenie/core/helper/cherryToast/cherry_toast_msgs.dart';
import 'package:recogenie/core/helper/extensions.dart';
import 'package:recogenie/core/routing/routs.dart';
import '../../../../../core/Responsive/UiComponents/info_widget.dart';

  class AuthenticationScreen extends StatefulWidget {
    const AuthenticationScreen({super.key});

    @override
    State<AuthenticationScreen> createState() => _AuthenticationScreenState();
  }

  class _AuthenticationScreenState extends State<AuthenticationScreen> {

    @override
    Widget build(BuildContext context) {
      return InfoWidget(builder: (context, deviceInfo) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {

            if(state is AuthError){
              CherryToastMsgs.showErrorToast(context, 'Error', state.error, deviceInfo);
            }else if (state is AuthSuccess){
              getIt<CartCubit>().fetchCartItems();
              context.pushNamed(Routes.homeScreen);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body:  SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: deviceInfo.screenHeight * 0.1,start: deviceInfo.screenWidth * 0.1,end: deviceInfo.screenWidth * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Recogenie App',style: TextStyle(color: Colors.black,fontSize: deviceInfo.screenWidth * 0.07,fontWeight: FontWeight.bold),),

                      SizedBox(height: deviceInfo.screenHeight * 0.03,),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Color(0xFF009688), Color(0xFF673AB7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Icon(
                          Icons.fastfood_outlined,
                          size: deviceInfo.screenWidth * 0.35,
                          color: Colors.white, // You must still set a base color, usually white.
                        ),
                      ),


                      SizedBox(height: deviceInfo.screenHeight * 0.015,),

                      context.read<AuthCubit>().isLoginWidget ?
                      SignInWidget() : SignUpWidget(),
                    ],

                  ),
                ),
              ),
            );
          },
        );
      });
    }
  }