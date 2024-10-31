import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Email :',
          style: TextStyle(fontSize: 20.sp, color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: Text(email,
              style: TextStyle(fontSize: 15.sp, color: Colors.white)),
        ),
      ],
    );
  }
}
