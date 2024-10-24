import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:chatapp/core/widget/photo_widget.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.userEntites});
  final UserEntites userEntites;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: Container(
            height: 40.h,
            width: 40.w,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        photo_widget(userEntites: userEntites, size: 50),
        SizedBox(
          width: 5.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: userEntites.name,
                fontsize: 20,
                fontcolor: Colors.white,
                fontWeight: FontWeight.w500),
            CustomText(
                text: 'last seen',
                fontsize: 15,
                fontcolor: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w100),
          ],
        ),
      ],
    );
  }
}
