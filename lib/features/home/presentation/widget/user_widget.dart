import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:chatapp/core/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidget extends StatelessWidget {
  const UserWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.status,
      required this.id});
  final String? imageUrl;
  final String name;
  final String? status;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(255, 147, 209, 247),
      elevation: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 70.h,
              width: 70.w,
              padding: const EdgeInsets.all(2),
              child: imageUrl != null
                  ? InkWell(
                      onTap: () {
                        context.PushNamd(Routes.fullscreenImage,
                            arguments: imageUrl);
                      },
                      child: Hero(
                        tag: '$imageUrl-$id',
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
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
                  : Image.asset('assets/images/boy.png')),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: name,
                  fontsize: 20,
                  fontcolor: Colors.black,
                  fontWeight: FontWeight.w800),
              const CustomText(
                  text: "status",
                  fontsize: 15,
                  fontcolor: Colors.grey,
                  fontWeight: FontWeight.w400)
            ],
          ),
        ],
      ),
    );
  }
}
