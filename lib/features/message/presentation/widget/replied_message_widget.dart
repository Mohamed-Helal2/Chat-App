import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/messages_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepliedMessageWidget extends StatelessWidget {
  const RepliedMessageWidget({
    super.key,
    required this.widget,
    required this.messages
  });

  final MessagesWidget widget;
  final List messages;
  @override
  Widget build(BuildContext context) {
    String replyContent;

    if (widget.messageEntites.replyMessage!['replycontent'] is String) {
      replyContent = widget.messageEntites.replyMessage!['replycontent'];
    } else if (widget.messageEntites.replyMessage!['replycontent']!
        .containsKey('record')) {
      replyContent = 'record';
    } else if (widget.messageEntites.replyMessage!['replycontent']!
        .containsKey('allphotos')) {
      replyContent = 'photo';
    } else if (widget.messageEntites.replyMessage!['replycontent']!
        .containsKey('latitude')) {
      replyContent = 'Location';
    } else if (widget.messageEntites.replyMessage!['replycontent']!
        .containsKey('pdfName')) {
      replyContent = 'Pdf';
    } else {
      replyContent = 'Unsupported content';
    }

    print(
        "11 ------------- ${widget.messageEntites.replyMessage!['replycontent'].runtimeType}");
    // print(
    //     "22 ------------- ${widget.messageEntites.replyMessage!['replycontent']!.containsKey('record')}");
    return InkWell(
      onTap: () {
       // print("----------- EEEE");
        //  context.read<MessageCubit>().getMessageIndexById(messages: messages, messageId: messageId)
        context.read<MessageCubit>().changecolor(
          messageId: widget.messageEntites.replyMessage!['messageId'],
          messages: messages
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: widget.messageEntites.replyMessage!['senderid'] ==
                    FirebaseAuth.instance.currentUser!.uid
                ? const Color.fromARGB(255, 182, 206, 185)
                : const Color.fromARGB(255, 169, 153, 153),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.messageEntites.replyMessage!['senderid'] ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? 'YOU'
                    : widget.name,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff2C2C2C))),
            Text(
              replyContent,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 64, 64),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
