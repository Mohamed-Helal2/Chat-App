import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class photo_widget extends StatelessWidget {
  const photo_widget({
    super.key,
      this.photourl,
    required this.size,
   });
  final String? photourl;
  final double size;
   @override
  Widget build(BuildContext context) {
    return Container(
        height: size.h,
        width: size.w,
        padding: const EdgeInsets.all(2),
        child:  photourl != null
            ? InkWell(
                onTap: () {
                  context.PushNamd(Routes.fullscreenImage,
                      arguments:  photourl);
                },
                child: Hero(
                  tag: '${ photourl}-1',
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: photourl!,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 243, 33, 124),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : Image.asset('assets/images/boy.png'));
  }
}
