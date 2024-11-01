import 'package:audioplayers/audioplayers.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/record_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sound/flutter_sound.dart';

class ChatRecordWidget extends StatelessWidget {
  const ChatRecordWidget(
      {super.key, required this.audiocontent, required this.index});
  final dynamic audiocontent;
  final int index;
  @override
  Widget build(BuildContext context) {
    final messageCubit = context.read<MessageCubit>();
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is audiodurationstate) {
          // Handle duration updates if necessary
        }
        if (state is timeprogrssstate) {
          // Handle progress updates
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    messageCubit.longPlay(
                        audioUrl: audiocontent['record'], index: index);
                  },
                  child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        messageCubit.playbackStates[index] ==
                                PlayerState.playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow,
                        size: 25,
                      )),
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 230.w,
                  child: Slider.adaptive(
                    value: (messageCubit.audioProgresses[index]! / 1000)
                        .floorToDouble(),
                    min: 0,
                    max: (messageCubit.audioDurations[index]! / 1000)
                        .floorToDouble(),
                    onChanged: (value) {
                      messageCubit.seekTo(value.toInt(), index);
                    },
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gettimestring(messageCubit.audioProgresses[index]!),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  gettimestring(audiocontent['audiotime']),
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
