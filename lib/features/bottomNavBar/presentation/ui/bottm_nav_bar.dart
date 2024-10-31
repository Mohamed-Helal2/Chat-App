import 'package:chatapp/core/di/dipendency_injection.dart';
import 'package:chatapp/features/bottomNavBar/presentation/bloc/bottom_nav_bar_cubit.dart';
 import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottmNavBar extends StatelessWidget {
  const BottmNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<UsersCubit>()..getalluser(),
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xff2D2D37),
            bottomNavigationBar: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(8, 20))
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: const Color.fromARGB(255, 132, 35, 29),
                  unselectedItemColor: const Color.fromARGB(255, 81, 81, 81),
                  currentIndex:
                      context.read<BottomNavBarCubit>().navigatorValue,
                  onTap: (value) {
                    context
                        .read<BottomNavBarCubit>()
                        .changeSelectedvalue(value);
                  },
                  items: const [
                    
                    BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.users,
                          size: 29,
                        ),
                        label: "Connects"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.message,
                          size: 29,
                        ),
                        label: "Chats"),
                    BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        size: 29,
                      ),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
            body: context.read<BottomNavBarCubit>().currentscreen,
          );
        },
      ),
    );
  }
}
