import 'package:chatapp/core/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackbarMessage {
  void showSnackBar(
      {required BuildContext context,
      required IconData? icon,
      required String message,
      required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CustomText(
                text: message,
                maxlines: 2,
                fontsize: 15,
                fontcolor: Colors.white,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          right: 20,
          left: 20),
    ));
  }
}
