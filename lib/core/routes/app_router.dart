import 'package:chatapp/core/di/dipendency_injection.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/features/bottomNavBar/presentation/bloc/bottom_nav_bar_cubit.dart';
import 'package:chatapp/features/bottomNavBar/presentation/ui/bottm_nav_bar.dart';
import 'package:chatapp/features/home/presentation/widget/full_screen_image_widget.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:chatapp/features/login/presentation/pages/login_screen.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:chatapp/features/signup/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginscreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getit<LoginCubit>(),
                  child: const LoginScreen(),
                ));
      case Routes.signupscreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getit<SignupCubit>(),
                  child: const SignupScreen(),
                ));
      case Routes.bottomNavBAr:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getit<BottomNavBarCubit>(),
            child: const BottmNavBar(),
          ),
        );
      case Routes.fullscreenImage:
        final imageUrl = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => FullScreenImage(imageUrl: imageUrl),
        );
      default:
        return null;
    }
  }
}
