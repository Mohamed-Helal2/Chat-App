import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, this.status});
  final String? status;
  @override
  Widget build(BuildContext context) {
    return status != null
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 2)),
            child: Text(status!,
                style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
          )
        : const SizedBox.shrink();
  }
}
