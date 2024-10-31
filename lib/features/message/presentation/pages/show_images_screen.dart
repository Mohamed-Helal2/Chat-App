import 'dart:io';

import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/message/presentation/widget/image/list_photo_widget.dart';
import 'package:chatapp/features/message/presentation/widget/image/photo_caption_widget.dart';
import 'package:chatapp/features/message/presentation/widget/image/photo_listner.dart';
import 'package:chatapp/features/message/presentation/widget/image/send_photo_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImageScreen extends StatelessWidget {
  const ShowImageScreen(
      {super.key, required this.imagepathes, required this.userEntites});
  final List<String> imagepathes;
  final UserEntites userEntites;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                  child: PhotoViewGallery.builder(
                onPageChanged: (index) {
                  print("===================>> ${index}");
                  context.read<MessageCubit>().changephotonumer(index: index);
                  context.read<MessageCubit>().changephotonumer2(index2: index);
                },
                pageController: context.read<MessageCubit>().pageController,
                itemCount: imagepathes.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(File(imagepathes[index])),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
              )),
              Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(height: 15.h),
                  ListPhotoWidget(imagepathes: imagepathes),
                  const PhotoCaptionWidget(),
                  SendPhotoButtonWidget(
                      allimages: imagepathes, chatid: userEntites.id,
                    userEntites: userEntites,
                   
                      ),
                  const PhotoListner()
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
