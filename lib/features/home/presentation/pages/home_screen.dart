import 'package:chatapp/features/home/presentation/widget/build_user_widget.dart';
import 'package:chatapp/features/home/presentation/widget/search_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2D2D37),
      body: Padding(
          padding: EdgeInsets.only(top: 40.h, right: 10.w, left: 10.w),
          child: const Column(
            children: [
              Searchuserwidget(),
              BuildUserWidget(),
            ],
          )),
    );
  }
}
