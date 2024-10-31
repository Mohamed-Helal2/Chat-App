import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:chatapp/features/mychats/presentation/widget/my_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllChatsListWidget extends StatelessWidget {
  const AllChatsListWidget({super.key, required this.mychatEntities});
  final List<MychatsEntities> mychatEntities;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.h, right: 10.w, left: 10.w),
      child: ListView.builder(
        itemCount: mychatEntities.length,
        itemBuilder: (context, index) {
          return MyChatWidget(mychatsEntities: mychatEntities[index]);
        },
      ),
    );
  }
}
