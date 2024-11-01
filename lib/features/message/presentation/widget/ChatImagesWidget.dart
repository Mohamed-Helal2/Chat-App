import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatImagesWidget extends StatelessWidget {
  final dynamic photoes;

  ChatImagesWidget({required this.photoes});

  @override
  Widget build(BuildContext context) {
    if (photoes['allphotos'].length == 1) {
      // Single image with caption
      return Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(imageUrl: photoes['allphotos'][0])),
            SizedBox(height: 5.h),
            if (photoes['photocaption'] != null)
              Text(
                photoes['photocaption'],
                style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color.fromARGB(255, 242, 240, 240)),
              ),
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            itemCount: photoes['allphotos'].length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      CachedNetworkImage(imageUrl: photoes['allphotos'][index])
                  //  Image.network(
                  //   photoes['allphotos'][index],
                  //   fit: BoxFit.cover,
                  // ),
                  );
              //const SizedBox(height: 8),
            },
          ),
          SizedBox(height: 5.h),
          if (photoes['photocaption'] != null)
            Text(
              photoes['photocaption'],
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color.fromARGB(255, 242, 240, 240)),
            ),
        ],
      );
    }
  }
}
