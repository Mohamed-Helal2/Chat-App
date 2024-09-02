import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/signup/data/datasource/signup_remote_data_source.dart';
import 'package:chatapp/features/signup/data/model/signup_model.dart';
import 'package:chatapp/features/signup/domain/entites/signup_entites.dart';
import 'package:chatapp/features/signup/domain/repostories/signup_repostories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SignupRepostoriesimpl implements SignUpRepostories {
  final SignupRemoteDataSource signupRemoteDataSource;
  final NetworkInfo networkInfo;
  SignupRepostoriesimpl(
      {required this.networkInfo, required this.signupRemoteDataSource});
  @override
  Future<Either<Failure, Unit>> signup(
      {required SignupEntites signupentities, XFile? profilepic}) async {
    if (await networkInfo.isconnected) {
      try {
        final SignupModel signupmodel = SignupModel(
            email: signupentities.email,
            password: signupentities.password,
            name: signupentities.name,
            userid: signupentities.userid,
            photourl: signupentities.photourl);
        await signupRemoteDataSource.signup(signupmodel);
        return right(unit);
      } on FirebaseAuthException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(
      {required XFile? profilepic}) async {
    if (await networkInfo.isconnected) {
      try {
        final photourl = await signupRemoteDataSource.uploadImage(profilepic);
        return right(photourl);
      } on FirebaseException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
