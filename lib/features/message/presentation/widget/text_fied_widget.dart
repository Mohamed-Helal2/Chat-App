import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/emoji_picker_widget.dart';
import 'package:chatapp/features/message/presentation/widget/record_time_widget.dart';
import 'package:chatapp/features/message/presentation/widget/reply_message_widget.dart';
import 'package:chatapp/features/message/presentation/widget/send_mic_icon_widget.dart';
import 'package:chatapp/features/message/presentation/widget/show_bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.userEntites});
  final UserEntites userEntites;
  final bool isRTL = false;
  final String text = "";

  @override
  Widget build(BuildContext context) {
    final messagecubit = context.read<MessageCubit>();

    return BlocConsumer<MessageCubit, MessageState>(listener: (context, state) {
      if (state is RecordingInProgressstate) {
        print("---- text");
        state.duration;
      }
    }, builder: (context, state) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                if (messagecubit.replyMessage != null)
                  ReplyMessageWidget(
                    messageEntites: messagecubit.replyMessage!,
                    name: userEntites.name,
                  ),
                messagecubit.isrecord == false
                    ? customTextFormField(
                        focusNode: messagecubit.focusNode,
                        hintText: 'Type Your Message here',
                        onTap: () {
                          if (messagecubit.isshowemoji) {
                            messagecubit.showemoji();
                          }
                        },
                        
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                        fillColor: const Color.fromARGB(255, 69, 69, 69),
                        onChanged: (p0) {
                          messagecubit.changeIcon();
                        },
                        focusedBorder: messagecubit.replyMessage != null
                            ? const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)))
                            : null,
                        suffixIcon: IconButton(
                          onPressed: () {
                            messagecubit.focusNode.unfocus();
                            displayBottomSheet(
                                context: context, chatid: userEntites.id);
                            //   messagecubit.showImages();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            messagecubit.focusNode.unfocus();
                            messagecubit.showemoji();
                          },
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        controller: messagecubit.messagecontroller,
                        contentPadding: const EdgeInsets.all(17),
                      )
                    : const RecordTimeWidget(),
                SizedBox(height: 3.h),
                if (messagecubit.isshowemoji) const EmojiPickerWidget(),
              ],
            ),
          ),
          SendMicIconWidget(chatid: userEntites.id),
        ],
      );
    });
  }
}
