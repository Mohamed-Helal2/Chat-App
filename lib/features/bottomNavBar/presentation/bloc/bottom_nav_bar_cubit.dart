import 'package:bloc/bloc.dart';
import 'package:chatapp/core/di/dipendency_injection.dart';
import 'package:chatapp/features/home/presentation/pages/home_screen.dart';
import 'package:chatapp/features/mychats/presentation/bloc/allmychats_cubit.dart';
import 'package:chatapp/features/mychats/presentation/pages/allmychats_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int navigatorValue = 1;
  Widget currentscreen = const HomeScreen();

  void changeSelectedvalue(int selected_value) {
    navigatorValue = selected_value;
    switch (selected_value) {
      case 0:
        currentscreen = const Scaffold(
          body: Center(
            child: Text("Story"),
          ),
        );
        break;
      case 1:
        currentscreen = const HomeScreen();
        break;
      case 2:
        currentscreen = currentscreen = BlocProvider(
          create: (context) => getit<AllmychatsCubit>()..getallMyChats(),
          child: const Scaffold(
            backgroundColor: const Color(0xff2D2D37) ,
            body: AllmychatsScreen()),
        );
        break;
      case 3:
        currentscreen = const Scaffold(
          body: Center(
            child: Text("Profile"),
          ),
        );
        break;
    }
    emit(NavigateState(navigatValue: navigatorValue));
  }
}
