import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/ChatImagesWidget.dart';
import 'package:chatapp/features/message/presentation/widget/chat_location_widget.dart';
import 'package:chatapp/features/message/presentation/widget/chat_pdf_widget.dart';
import 'package:chatapp/features/message/presentation/widget/chat_record_widget.dart';
import 'package:chatapp/features/message/presentation/widget/replied_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget(
      {super.key,
      required this.messageEntites,
      required this.id,
      required this.name,
      required this.index,
      required this.messages});

  final MessageEntites messageEntites;
  final String id;
  final String name;
  final int index;
  final List messages;

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  @override
  void initState() {
    context.read<MessageCubit>().readType(
        chatid: widget.id, messageid: widget.messageEntites.messageId!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.messageEntites.timestamp;
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        bool isSelected =
            context.read<MessageCubit>().selectedIndex == widget.index;
        return SwipeTo(
          child: AnimatedContainer(
            color: isSelected
                ? Colors.blue
                : Colors.transparent, //widget.containercolor,
            //  context.read<MessageCubit>().containercolor,
            // Default color
            duration: const Duration(milliseconds: 300),
            child: Align(
              alignment: widget.messageEntites.senderid ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                        color: widget.messageEntites.senderid ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? const Color.fromARGB(255, 62, 90, 66)
                            : const Color.fromARGB(255, 100, 81, 81),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.messageEntites.replyMessage != null)
                          RepliedMessageWidget(
                            widget: widget,
                            messages: widget.messages,
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.messageEntites.messageType == 'text'
                                      ? Text(
                                          widget.messageEntites.content,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: const Color.fromARGB(
                                                  255, 242, 240, 240)),
                                        )
                                      : widget.messageEntites.messageType ==
                                              'photo'
                                          ? ChatImagesWidget(
                                              photoes:
                                                  widget.messageEntites.content)
                                          : widget.messageEntites.messageType ==
                                                  'Location'
                                              ? ChatLocationWidget(
                                                  latLng: LatLng(
                                                      widget.messageEntites
                                                          .content['latitude'],
                                                      widget.messageEntites
                                                              .content[
                                                          'longitude']))
                                              : widget.messageEntites
                                                          .messageType ==
                                                      'Pdf'
                                                  ? ChatPdfWidget(
                                                      content: widget
                                                          .messageEntites
                                                          .content)
                                                  : ChatRecordWidget(
                                                      audiocontent: widget
                                                          .messageEntites
                                                          .content,
                                                      index: widget.index,
                                                    ),
                                  Text(
                                    formattedTime,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.messageEntites.senderid ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? widget.messageEntites.readType
                          ? const Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(255, 149, 206, 252),
                            )
                          : const Icon(
                              Icons.check,
                              color: Colors.grey,
                            )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
          onRightSwipe: (details) {
            context
                .read<MessageCubit>()
                .replyToMessage(widget.messageEntites, widget.index);
          },
        );
      },
    );
  }
}
