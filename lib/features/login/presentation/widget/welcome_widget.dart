import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/widget/Custom_Text.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: CustomText(
            text: "Welcome",
            fontsize: 40,
            fontcolor: Colors.white,
            // align: TextAlign.left,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: CustomText(
              text: "Lets Sign You in",
              fontsize: 25,
              fontcolor: Colors.white,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 35.h,
        ),
      ],
    );
  }
}
