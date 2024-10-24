import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoListner extends StatelessWidget {
  const PhotoListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is SucessMessageState) {
          context.pop();
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
