import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/repostories/location_repostories.dart';
import 'package:dartz/dartz.dart';
 import 'package:location/location.dart';

class GetMyLocationUseCase {
  final LocationRepostories locationRepostories;

  GetMyLocationUseCase({required this.locationRepostories});

  Future<Either<Failure, Unit>> requestLocatoinService() async {
    return await locationRepostories.requestLocationService();
  }

  Future<Either<Failure, Unit>> requestLocationPermission() async {
    return await locationRepostories.requestLocationPermission();
  }
  Future<Either<Failure,LocationData>> getMyLocation() async {
    return await locationRepostories.getMyLocation();
  }
}

