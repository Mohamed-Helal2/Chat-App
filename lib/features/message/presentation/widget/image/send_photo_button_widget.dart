import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendPhotoButtonWidget extends StatelessWidget {
  const SendPhotoButtonWidget(
      {super.key, required this.allimages, required this.chatid});
  final List<String> allimages;
  final String chatid;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(130, 0, 168, 132),
        ),
        child: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is loadinguploadimageState) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return IconButton(
                  onPressed: () {
                    context.read<MessageCubit>().focusNode.unfocus();
                    context
                        .read<MessageCubit>()
                        .sendimages(images: allimages, chatid: chatid);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 182, 174, 174),
                    size: 30,
                  ));
            }
          },
        ),
      ),
    );
  }
}
