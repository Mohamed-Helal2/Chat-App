import 'dart:io';

import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListPhotoWidget extends StatelessWidget {
  const ListPhotoWidget({
    super.key,
    required this.imagepathes,
  });

  final List<String> imagepathes;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is removeImagestate) {
          print('--------------------- sss');
          state.pickedImagesPathes;
        }
      },
      builder: (context, state) {
        return Container(
          // color: Colors.deepOrangeAccent,
           height: 50.h,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagepathes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context
                                .read<MessageCubit>()
                                //.changephotonumer(index: index);
                                .photonumber ==
                            index
                        ? context
                            .read<MessageCubit>()
                            .removephoto(index: index, allimages: imagepathes)
                        //imagepathes.removeAt(index)
                        : context
                            .read<MessageCubit>()
                            .changephotonumer(index: index);
                    print("----- ${context.read<MessageCubit>().photonumber}");
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 60.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        border:
                            context.read<MessageCubit>().photonumber == index
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: FileImage(
                              File(imagepathes[index]),
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: context.read<MessageCubit>().photonumber == index
                          ? const Icon(
                              Icons.delete_outline_sharp,
                              size: 40,
                              color: Color.fromARGB(154, 255, 255, 255),
                            )
                          : null),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
