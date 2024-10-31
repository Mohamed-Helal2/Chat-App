import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListMessageWidget extends StatelessWidget {
  const ListMessageWidget({
    required this.userEntites,
    required this.focusNode,
    super.key,
  });
   final UserEntites userEntites;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      
      buildWhen: (previous, current) =>
          current is SucessGetMessageState || current is FailureGetMessageState,
      builder: (context, state) {
        if (state is SucessGetMessageState) {
          print("---------------00");
          return Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            reverse: true,
            controller: context.read<MessageCubit>().listscrollcontroler,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      print(
                          "11 ----- ${context.read<MessageCubit>().getMessageIndexById(messages: state.allmessage, messageId: state.allmessage[index].messageId!)}");
                    },
                    child: MessagesWidget(
                      messageEntites: state.allmessage[index],
                      id: userEntites.id,
                      name: userEntites.name,
                      index: index,
                      messages: state.allmessage,
                    ),
                  ),
                  // Text("Test")
                ],
              );
            },
            itemCount: state.allmessage.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 6.h,
              );
            },
          ));
        } else if (state is LoadingGetMessageState) {
          return const Expanded(
            child:
                Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        } else {
          return const Expanded(
              child: Center(
            child: Text(
              "tesssssssso",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ));
        }
      },
    );
  }
}
