import 'package:chatapp/core/widget/Auth/or_login_with_widget.dart';
import 'package:chatapp/features/login/presentation/widget/login_with_google_widget.dart';
import 'package:chatapp/features/signup/presentation/widget/already_have_account_widget.dart';
import 'package:chatapp/features/signup/presentation/widget/listener_widget.dart';
import 'package:chatapp/features/signup/presentation/widget/loading_builder_widget.dart';
import 'package:chatapp/features/signup/presentation/widget/sign_up_form_widget.dart';
import 'package:chatapp/features/signup/presentation/widget/signup_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/pick_Image_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const PickImageWidget(),
              SizedBox(
                height: 10.h,
              ),
              const SignUpFormWidget(),
              const LoadingBuilderWidget(),
              const SignupButtonWidget(),
              SizedBox(
                height: 5.h,
              ),
              const OrLoginWithWidget(
                text: 'or Signup with',
              ),
              SizedBox(
                height: 10.h,
              ),
              const LoginWithGoogleWidget(),
              SizedBox(
                height: 20.h,
              ),
              const AlreadyHaveAccountWidget(),
              const ListenerWidget(),
            ],
          )),
        ),
      ),
    );
  }
}
