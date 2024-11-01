import 'package:flutter/material.dart';

import 'custom_text.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    this.onPressed0,
    required this.text,
  });
  final void Function()? onPressed0;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.center, colors: [
            Color.fromARGB(255, 85, 2, 7),
            Color.fromARGB(255, 160, 143, 144),
          ]),
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed0,
        child: CustomText(
            text: text,
           
            fontsize: 25,
            fontcolor: Colors.white,
            fontWeight: FontWeight.w300),
      ),
      
    );
  }
}
