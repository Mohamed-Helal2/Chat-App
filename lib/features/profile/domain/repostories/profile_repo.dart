import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/profile/domain/entites/profile_entites.dart';
import 'package:dartz/dartz.dart';

abstract class Profilerepo {
  Future<Either<Failure, ProfileEntites>> profiledata({required String userid});
}
