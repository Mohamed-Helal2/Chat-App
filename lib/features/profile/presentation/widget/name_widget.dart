import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Text(name, style: TextStyle(fontSize: 15.sp, color: Colors.white)),
    );
  }
}
