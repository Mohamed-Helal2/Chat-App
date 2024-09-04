import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepostories {
  Future<Either<Failure, List<UserEntites>>> getAllUaer();
}
