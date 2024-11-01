import 'package:chatapp/core/utils/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key, required this.latLng});
  final LatLng latLng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              circles: {
                Circle(
                    circleId: const CircleId('1'),
                    center: latLng,
                    radius: 10000,
                    fillColor: Colors.blue.withOpacity(0.45),
                    strokeColor: Colors.black,
                    strokeWidth: 2)
              },
              zoomControlsEnabled: false,
              markers: {
                Marker(
                    markerId: const MarkerId(
                      '1',
                    ),
                    position: latLng)
              },
              //   polylines: context.read<PlaceCubit>().polylines,
              initialCameraPosition: CameraPosition(target: latLng, zoom: 10),
              // onMapCreated: (controller) {
              //   context.read<PlaceCubit>().googleMapController = controller;
              // },
            ),
            Positioned(
              left: 10.w,
              top: 20.w,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
