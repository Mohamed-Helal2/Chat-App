import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/login/domain/entites/login_entities.dart';
import 'package:chatapp/features/login/domain/entites/user_entities.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepostories {
  Future<Either<Failure, UserEntities>> login(LoginEntities loginentities);
}
