import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPdfWidget extends StatelessWidget {
  const ChatPdfWidget({super.key, required this.content});
  final Map content;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.PushNamd(Routes.pdfViewerScreen, arguments: content);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: Image.asset(
              'assets/images/pdf.png',
            ),
          ),
          Text(
            content['pdfName'],
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
