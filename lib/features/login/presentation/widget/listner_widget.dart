import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/utils/snackbar.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListnerWidget extends StatelessWidget {
  const ListnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SucessLoginState) {
            context.PushNamd(Routes.homescreen);
            // SnackbarMessage().showSnackBar(
            //   context: context,
            //   message: "Sucess logged in",
            //   icon: Icons.error,
            //   color: const Color.fromARGB(255, 90, 2, 13),
            // );
          } else if (state is FailureLoginState) {
            SnackbarMessage().showSnackBar(
              context: context,
              message: state.errorMessage,
              icon: Icons.error,
              color: const Color.fromARGB(255, 2, 0, 0),
            );
          }
        },
        child: const SizedBox.shrink());
  }
}
