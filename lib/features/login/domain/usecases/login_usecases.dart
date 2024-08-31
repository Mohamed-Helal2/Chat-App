import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/login/domain/entites/login_entities.dart';
import 'package:chatapp/features/login/domain/entites/user_entities.dart';
import 'package:chatapp/features/login/domain/repostories/login_repostories.dart';
import 'package:dartz/dartz.dart';

class LoginUsecases {
  final LoginRepostories loginrepostories;

  LoginUsecases({required this.loginrepostories});

  Future<Either<Failure, UserEntities>> login(
      LoginEntities loginentities) async {
    return await loginrepostories.login(loginentities);
  }
}
