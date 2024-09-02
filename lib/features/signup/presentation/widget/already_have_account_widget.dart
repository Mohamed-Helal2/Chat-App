import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushReplacementNamed(Routes.loginscreen);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "Already Have Account ",
            fontsize: 16,
            fontcolor: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          CustomText(
            text: "LOGIN",
            fontsize: 17,
            fontcolor: Colors.blue,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
