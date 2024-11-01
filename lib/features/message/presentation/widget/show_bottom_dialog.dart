import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/data/model/grid_view_model.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future displayBottomSheet(
    {required BuildContext context,
    required String chatid,
    required UserEntites userentites
     }) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: BlocProvider.value(
          value: BlocProvider.of<MessageCubit>(context),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 200.h,
            child: GridView.builder(
              itemCount: gridviewitem.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final item = gridviewitem[index]; // Get the item data
                final messagecubit = context.read<MessageCubit>();
                return InkWell(
                  onTap: () async {
                    // Handle tap event differently for each item
                    switch (item.actionType) {
                      case 'camera':
                        messagecubit.test(index);
                        break;
                      case 'Gallery':
                        await messagecubit.showImages();
                        Navigator.pop(context);
                        break;
                      case 'pdf':
                        await messagecubit.uploadpdf(
                            chatid: chatid, userentites: userentites
                          
                            );
                        Navigator.pop(context);
                        break;
                      case 'Location':
                        await messagecubit.sendMyLocation(
                            chatid: chatid,  userentites: userentites
                         
                            );
                        Navigator.pop(context);
                        break;
                      default:
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white, width: 0.2),
                        ),
                        child: item.icon,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
