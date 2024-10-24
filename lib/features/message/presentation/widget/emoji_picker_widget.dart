import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EmojiPickerWidget extends StatelessWidget {
  const EmojiPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        print("--- ${emoji.emoji}");
        context.read<MessageCubit>().changeIcon();
      },
      
      textEditingController: context.read<MessageCubit>().messagecontroller,
      config: Config(
        height: 240.h,

        categoryViewConfig: const CategoryViewConfig(
          backgroundColor: Color(0xff2C2C2C),
        ),
        bottomActionBarConfig: const BottomActionBarConfig(
            showBackspaceButton: true, showSearchViewButton: true),
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          backgroundColor: const Color(0xff2C2C2C),
          columns: 7,
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        // swapCategoryAndBottomBar: false,
        // skinToneConfig: const SkinToneConfig(),
        // categoryViewConfig: const CategoryViewConfig(),
        // bottomActionBarConfig: const BottomActionBarConfig(),
        // searchViewConfig: const SearchViewConfig(),
      ),
    );
  }
}
