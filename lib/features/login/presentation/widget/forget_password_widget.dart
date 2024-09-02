import 'package:chatapp/core/widget/custom_text.dart';
import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: const CustomText(
        text: "forget password",
        fontsize: 17,
        fontcolor: Color.fromARGB(255, 120, 36, 41),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
