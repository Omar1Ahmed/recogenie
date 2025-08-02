
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recogenie/Features/cart/presentation/cart_screen/logic/cart_cubit.dart';
import 'package:recogenie/Features/cart/presentation/cart_screen/ui/cart_screen.dart';
import 'package:recogenie/Features/home/presentation/home_screen/logic/home_cubit.dart';
import 'package:recogenie/Features/home/presentation/home_screen/ui/home_screen.dart';
import 'package:recogenie/core/di/injection.dart';
import 'package:recogenie/core/routing/routs.dart';

import '../../Features/auth/presentation/auth_screen/logic/auth_cubit.dart';
import '../../Features/auth/presentation/auth_screen/ui/authentication_screen.dart';

class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.authScreen:
        return MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => getIt<AuthCubit>(), child: const AuthenticationScreen()));
        case Routes.cartScreen:
        return MaterialPageRoute(builder: (context) => BlocProvider.value(value: getIt<CartCubit>()..fetchCartItemsDetails(), child: const CartScreen()));
        case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => getIt<HomeCubit>()..getMenuItems(), child: const HomeScreen()));
      default:
        return null;
    }
  }
}
