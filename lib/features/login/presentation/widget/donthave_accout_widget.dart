import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:flutter/material.dart';

class DonthaveAccoutWidget extends StatelessWidget {
  const DonthaveAccoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.PushNamd(Routes.signupscreen);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "DONT HAVE ACCOUNT?  ",
            fontsize: 16,
            fontcolor: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          CustomText(
            text: "SIGN UP",
            fontsize: 17,
            fontcolor: Colors.blue,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
