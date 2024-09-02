import 'dart:io';

import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
            child: Container(
          height: 150.h,
          width: 150.w,
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              if (context.read<SignupCubit>().profilePic != null) {
                return ClipRRect(
                    child: Image.file(
                        File(context.read<SignupCubit>().profilePic!.path)));
              } else {
                return ClipRRect(
                  child: Image.asset('assets/images/boy.png'),
                );
              }
            },
          ),
        )
            //  },
            // ),
            ),
        Positioned(
          bottom: 5,
          right: 15,
          //left: 250,
          child: GestureDetector(
            onTap: () async {
              context.read<SignupCubit>().pickImage();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.camera_alt_sharp,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
