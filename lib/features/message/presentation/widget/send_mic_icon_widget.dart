import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMicIconWidget extends StatelessWidget {
  const SendMicIconWidget(
      {super.key, required this.chatid, required this.userEntites});
  final String chatid;
  final UserEntites userEntites;

  @override
  Widget build(BuildContext context) {
    final micCubit = context.read<MessageCubit>();
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: BlocConsumer<MessageCubit, MessageState>(
          listener: (context, state) {
            if (state is RecordingInProgressstate) {
              state.duration;
            }
          },
          builder: (context, state) {
            return CircleAvatar(
              radius: micCubit.micIconSize,
              backgroundColor: micCubit.micColor,
              child: micCubit.isMic
                  ? GestureDetector(
                      onLongPress: () async {
                        micCubit.startRecording();
                      },
                      onLongPressEnd: (details) {
                        print("---------------- s");
                        micCubit
                            .
                            //.stopRecording();
                            sendrecord(
                                chatid: chatid,  userentites: userEntites);
                      },
                      child:
                          const Icon(Icons.mic, color: Colors.white, size: 30))
                  : IconButton(
                      onPressed: () {
                        micCubit.sendMessage(
                            chatid: chatid,
                            content: micCubit.messagecontroller.text.trim(),
                            messagetype: 'text',
                           
                            userentites: userEntites);
                      },
                      icon: const Icon(Icons.send,
                          color: Color.fromARGB(255, 33, 87, 35), size: 30),
                    ),
            );
          },
        ));
  }
}
