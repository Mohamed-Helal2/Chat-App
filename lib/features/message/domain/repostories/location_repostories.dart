import 'package:chatapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

abstract class LocationRepostories {
  Future<Either<Failure, Unit>> requestLocationService();
  Future<Either<Failure, Unit>> requestLocationPermission();
  Future<Either<Failure,LocationData>> getMyLocation();
}