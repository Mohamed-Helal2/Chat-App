import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/button.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Signin",
      onPressed0: () {
        if (context.read<LoginCubit>().loginformkey.currentState!.validate()) {
          context.read<LoginCubit>().login();
        }
      },
    );
  }
}
