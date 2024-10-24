import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class photo_widget extends StatelessWidget {
  const photo_widget({
    super.key,
    required this.userEntites,
    required this.size,
   });
  final UserEntites userEntites;
  final double size;
   @override
  Widget build(BuildContext context) {
    return Container(
        height: size.h,
        width: size.w,
        padding: const EdgeInsets.all(2),
        child: userEntites.photourl != null
            ? InkWell(
                onTap: () {
                  context.PushNamd(Routes.fullscreenImage,
                      arguments: userEntites.photourl);
                },
                child: Hero(
                  tag: '${userEntites.photourl}-${userEntites.id}',
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userEntites.photourl!,
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
