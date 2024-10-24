import 'package:chatapp/core/routes/routes.dart';
import 'package:chatapp/core/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChatLocationWidget extends StatelessWidget {
  const ChatLocationWidget({super.key,required this.latLng});
  final LatLng latLng;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.PushNamd(Routes.googlemapScreen,arguments: latLng);
      },
      child: Container(
          height: 110.h,
          width: 120.w,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                   AssetImage('assets/images/get_location.jpg')))),
    );
  }
}
