import 'package:chatapp/core/widget/photo_widget.dart';
import 'package:chatapp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatapp/features/profile/presentation/widget/email_widget.dart';
import 'package:chatapp/features/profile/presentation/widget/name_widget.dart';
import 'package:chatapp/features/profile/presentation/widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfieScreen extends StatelessWidget {
  const ProfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff2D2D37),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSucessState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    photo_widget(
                        size: 200, photourl: state.profileentites.photourl),
                    SizedBox(height: 10.h),
                    NameWidget(name: state.profileentites.name),
                    SizedBox(height: 10.h),
                    StatusWidget(status: state.profileentites.status),
                    SizedBox(height: 10.h),
                    EmailWidget(email: state.profileentites.email)
                  ],
                ),
              );
            } else if (state is Profileloadingstate) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
