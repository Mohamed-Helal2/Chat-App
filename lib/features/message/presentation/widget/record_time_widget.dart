import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordTimeWidget extends StatelessWidget {
  const RecordTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is RecordingInProgressstate) {
          state.duration;
        }
        if (state is startrecordstate) {
          print("listner  --------- start record state ");
        }
        if (state is RecordingStoppedState) {
          print("listner  --------- stop state ");
        }
        if (state is ChangemicIconSizeState2) {}
        if (state is InitialrecordState) {
          print("listner  --------- init ");
        }
        if (state is RecordingInProgressstate) {
          print("listner ----   ${state.duration}");
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            gettimestring(context.read<MessageCubit>().audiotime),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}

String gettimestring(int milliseconds) {
  String minutes =
      '${(milliseconds / 60000).floor() < 10 ? 0 : ''} ${(milliseconds / 60000).floor()}';
  String seconds =
      "${(milliseconds / 1000).floor() % 60 < 10 ? 0 : ''} ${(milliseconds / 1000).floor() % 60} ";
  return '$minutes:$seconds';
}

 