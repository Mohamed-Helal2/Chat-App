import 'package:flutter/material.dart';
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
              initialCameraPosition: CameraPosition(target: latLng, zoom: 10),
            ),
          ],
        ),
      ),
    );
  }
}
