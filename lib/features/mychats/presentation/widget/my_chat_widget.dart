import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:chatapp/core/widget/photo_widget.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:chatapp/features/mychats/presentation/bloc/allmychats_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MyChatWidget extends StatelessWidget {
  MyChatWidget({super.key, required this.mychatsEntities});
  final MychatsEntities mychatsEntities;
  final String name = FirebaseAuth.instance.currentUser!.displayName!;
  @override
  Widget build(BuildContext context) {
    Widget lastmessage;
    if (mychatsEntities.lastMessageType == 'text') {
      lastmessage = Text(
        mychatsEntities.lastMessage,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
      );
    } else if (mychatsEntities.lastMessageType == 'record') {
      lastmessage = Row(
        children: [
          Text(
            'record',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 10.w),
          const Icon(Icons.mic, size: 30, color: Colors.blue)
        ],
      );
    } else if (mychatsEntities.lastMessageType == 'photo') {
      lastmessage = Row(
        children: [
          Text(
            'photo',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 10.w),
          const Icon(Icons.photo, size: 30, color: Colors.blue)
        ],
      );
    } else if (mychatsEntities.lastMessageType == 'Location') {
      lastmessage = Row(
        children: [
          Text(
            'Location',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 10.w),
          const Icon(Icons.location_city, size: 30, color: Colors.green)
        ],
      );
    } else if (mychatsEntities.lastMessageType == 'Pdf') {
      lastmessage = Row(
        children: [
          Text(
            'Pdf',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 10.w),
          const Icon(Icons.picture_as_pdf, size: 30, color: Colors.red)
        ],
      );
    } else {
      lastmessage = const Text('Unsupported content');
    }
    DateTime dateTime = mychatsEntities.lastMessageTimestamp;
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    final UserEntites userEntites = UserEntites(
      id: mychatsEntities.otherParticipantId,
      name: mychatsEntities.otherParticipantName,
      email: mychatsEntities.otherParticipantEmail,
      photourl: mychatsEntities.otherParticipantPhotoUrl,
    );

    return InkWell(
      onTap: () {
        context.PushNamd(Routes.messagescreen, arguments: userEntites).then(
          (value) {
            context.read<AllmychatsCubit>().setUserInChatStatus(userEntites.id);
          },
        );
      },
      child: Card(
        shadowColor: const Color.fromARGB(255, 147, 209, 247),
        elevation: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            photo_widget(
                photourl: mychatsEntities.otherParticipantPhotoUrl, size: 70),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: mychatsEntities.otherParticipantName,
                          fontsize: 20,
                          fontcolor: Colors.black,
                          fontWeight: FontWeight.w800),
                      Padding(
                        padding: REdgeInsets.only(right: 10.h),
                        child: CustomText(
                            text: formattedTime,
                            fontsize: 10.sp,
                            fontcolor: Colors.grey,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mychatsEntities.otherParticipantInchat
                          ? CustomText(
                              text: ('$name is In Chat....').toString(),
                              fontsize: 15,
                              fontcolor: Colors.green,
                              fontWeight: mychatsEntities.lastMessageRead
                                  ? FontWeight.w400
                                  : FontWeight.bold)
                          : lastmessage
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
