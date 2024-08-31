import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/login/data/datasource/login_remote_data_source.dart';
import 'package:chatapp/features/login/data/model/login_model.dart';
import 'package:chatapp/features/login/domain/entites/login_entities.dart';
import 'package:chatapp/features/login/domain/entites/user_entities.dart';
import 'package:chatapp/features/login/domain/repostories/login_repostories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepostoriesImpl implements LoginRepostories {
  final LoginRemoteDataSource loginDataSource;
  final NetworkInfo networkInfo;

  LoginRepostoriesImpl(
      {required this.loginDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, UserEntities>> login(
      LoginEntities loginentities) async {
    if (await networkInfo.isconnected) {
      try {
        final LoginModel loginModel = LoginModel(
            email: loginentities.email, password: loginentities.password);
        final response = await loginDataSource.login(loginModel);
        return right(response);
      } on FirebaseAuthException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
