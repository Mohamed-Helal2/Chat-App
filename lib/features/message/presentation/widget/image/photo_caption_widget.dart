import 'package:chatapp/core/widget/custom_text_form_field.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoCaptionWidget extends StatelessWidget {
  const PhotoCaptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: const EdgeInsets.all(10.0),
      child: customTextFormField(
        controller: context.read<MessageCubit>().photocaptioncontroller,
        hintText: "Add Caption....",
        onTapOutside: (p0) {
          context.read<MessageCubit>().focusNode.unfocus();
        },
        hintStyle: const TextStyle(color: Colors.white),
        style: const TextStyle(color: Colors.white),
        fillColor: const Color.fromARGB(255, 58, 70, 78),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(40)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
