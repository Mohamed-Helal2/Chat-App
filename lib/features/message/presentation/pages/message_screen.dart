import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/presentation/widget/MessageListnerWidget.dart';
import 'package:chatapp/features/message/presentation/widget/buildappBar.dart';
import 'package:chatapp/features/message/presentation/widget/list_message_widget.dart';
import 'package:chatapp/features/message/presentation/widget/text_fied_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required this.userEntites});
  final UserEntites userEntites;
  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Scaffold(
      backgroundColor: const Color(0xff2C2C2C),
      body: Padding(
        padding:
            EdgeInsets.only(top: 40.h, left: 10.w, right: 10.w, bottom: 5.h),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.PushNamd(Routes.profilescreen,
                    arguments: userEntites.id);
              },
              child: AppBarWidget(
                userEntites: userEntites,
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 0.2,
              height: 10.h,
            ),
            ListMessageWidget(userEntites: userEntites, focusNode: focusNode),
            TextFieldWidget(
              userEntites: userEntites,

              //,focusNode: focusNode
            ),
            MessageListnerWidget(userEntites: userEntites),
          ],
        ),
      ),
    );
  }
}
