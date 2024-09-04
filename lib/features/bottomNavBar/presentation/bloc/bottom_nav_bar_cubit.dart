import 'package:bloc/bloc.dart';
import 'package:chatapp/features/home/presentation/pages/home_screen.dart';
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
        currentscreen = currentscreen = const Scaffold(
          body: Center(
            child: Text("All Chats"),
          ),
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
