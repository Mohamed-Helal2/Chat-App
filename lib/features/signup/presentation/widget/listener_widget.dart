import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/utils/snackbar.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';

class ListenerWidget extends StatelessWidget {
  const ListenerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) async {
        if (state is SucessSignupState) {
          context.pushReplacementNamed(Routes.loginscreen);
          SnackbarMessage().showSnackBar(
              context: context,
              message: 'now u can logged in',
              icon: Icons.check_box,
              color: Colors.green);
        } else if (state is FailureSignupState) {
          SnackbarMessage().showSnackBar(
            context: context,
            message: state.errorMessage,
            icon: Icons.error,
            color: const Color.fromARGB(255, 90, 2, 13),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
