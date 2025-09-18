import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/core/router/app_routes.dart';
import 'package:smart_ahwa_manager/feature/home/home_screen.dart';
import 'package:smart_ahwa_manager/feature/nav_bar/view/nav_bar.dart';
import 'package:smart_ahwa_manager/feature/nav_bar/view_model/nav_bar_cubit.dart';
import 'package:smart_ahwa_manager/feature/splash/splash_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splasahRouter:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.navBarRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NavBarCubit(),
            child: NavBarScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('لا يوجد بيانات '))),
        );
    }
  }
}
