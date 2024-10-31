import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:chatapp/core/widget/photo_widget.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.userEntites});

  final UserEntites userEntites;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.PushNamd(Routes.messagescreen, arguments: userEntites).then(
          (value) {
            context.read<UsersCubit>().setUserInChatStatus(userEntites.id);
            print("------------------------------- wwww");
          },
        );
      },
      child: Card(
        shadowColor: const Color.fromARGB(255, 147, 209, 247),
        elevation: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            photo_widget(photourl: userEntites.photourl, size: 70),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: userEntites.name,
                    fontsize: 20,
                    fontcolor: Colors.black,
                    fontWeight: FontWeight.w800),
                CustomText(
                    text: userEntites.status!,
                    fontsize: 15,
                    fontcolor: Colors.grey,
                    fontWeight: FontWeight.w400)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
