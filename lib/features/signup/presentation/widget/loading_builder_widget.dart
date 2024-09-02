import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingBuilderWidget extends StatelessWidget {
  const LoadingBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        if (state is LoadingSignupState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
