import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageListnerWidget extends StatelessWidget {
  const MessageListnerWidget({super.key, required this.userEntites});
  final UserEntites userEntites;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, MessageState>(
        listener: (context, state) {
          if (state is showimagesstatesucess) {
            context.PushNamd(Routes.showImgaesScreen, arguments: {
              'imagespathes': state.pickedImagesPathes,
              'userEntites': userEntites,
            });
          }
          // if (state is RecordingInProgressstate) {
          //   print("------------------- xx");
          //   state.duration;
          // }
        },
        child: const SizedBox.shrink());
  }
}
