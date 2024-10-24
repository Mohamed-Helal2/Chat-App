import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReplyMessageWidget extends StatelessWidget {
  const ReplyMessageWidget(
      {super.key, required this.messageEntites, required this.name});
  final MessageEntites messageEntites;
  final String name;

  @override
  Widget build(BuildContext context) {
    String replyContent;
    switch (messageEntites.messageType) {
      case 'text':
        replyContent = messageEntites.content;
        break;
      case 'photo':
        replyContent = 'photo';
        break;
      case 'record':
        replyContent = 'record';
        break;
      case 'Location':
        replyContent = 'Locatoin';
        break;
      case 'Pdf':
        replyContent = 'Pdf';
      default:
        replyContent = 'No Type';
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color:
              messageEntites.senderid == FirebaseAuth.instance.currentUser!.uid
                  ? const Color.fromARGB(255, 182, 206, 185)
                  : const Color.fromARGB(255, 169, 153, 153),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    messageEntites.senderid ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? "You"
                        : name,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff2C2C2C))),
                //  SizedBox(height: .h),
                Text(replyContent,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 26, 1, 1)))
              ],
            ),
          ),
          CircleAvatar(
              radius: 12,
              backgroundColor: const Color(0xff2C2C2C),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.read<MessageCubit>().cancelReplyToMessage();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
