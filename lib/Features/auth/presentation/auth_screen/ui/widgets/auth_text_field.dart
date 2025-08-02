import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Responsive/models/device_info.dart';
import '../../logic/password_visibility_cubit.dart';


Column buildAuthTextField({
  required DeviceInfo deviceInfo,
  bool isPassword = false,
  required controller,
  String? Function(String?)? validators,
  required String labelTxt,
  required String hintTxt,
  required BuildContext context,
  bool isHidden = false
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelTxt,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: deviceInfo.screenWidth * 0.04,
        ),
      ),

      Container(

        margin: EdgeInsetsDirectional.only(start: deviceInfo.screenWidth * 0.01,top: deviceInfo.screenHeight * 0.004),
        child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          canRequestFocus: true,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          obscureText: isPassword ? isHidden : false,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            suffixIcon: isPassword
                ? GestureDetector(
              child: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade500,
              ),
              onTap: () {
                context.read<PasswordVisibilityCubit>().toggleVisibility();
              },
            )
                : null,
            hintText: hintTxt,

            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                deviceInfo.screenWidth * 0.04,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade300,
          ),
          validator: validators,
          textInputAction: TextInputAction.next,
        ),)
    ],

  );
}