import 'package:chatapp/core/widget/button.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupButtonWidget extends StatelessWidget {
  const SignupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Signup",
      onPressed0: () {
        if (context
            .read<SignupCubit>()
            .signupformkey
            .currentState!
            .validate()) {
          context.read<SignupCubit>().signup();
        }
      },
    );
  }
}
