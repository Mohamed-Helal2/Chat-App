import 'package:chatapp/features/login/presentation/widget/forget_password_widget.dart';
import 'package:chatapp/features/login/presentation/widget/login_button_widget.dart';
import 'package:chatapp/features/login/presentation/widget/login_with_google_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/donthave_accout_widget.dart';
import '../widget/email_and_password_widget.dart';
import '../widget/or_login_with_widget.dart';
import '/features/login/presentation/widget/welcome_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.center, colors: [
          Color.fromARGB(255, 85, 2, 7),
          Color.fromARGB(255, 160, 143, 144),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeWidget(),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 30.h, right: 5.w, left: 5.w),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const EmailAndPasswordWidget(),
                    const ForgetPasswordWidget(),
                    const LoginButtonWidget(),
                    SizedBox(
                      height: 15.h,
                    ),
                    const OrLoginWithWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LoginWithGoogleWidget(),
                    SizedBox(
                      height: 30.h,
                    ),
                    const DonthaveAccoutWidget()
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
