import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/signup/domain/entites/signup_entites.dart';
import 'package:chatapp/features/signup/domain/repostories/signup_repostories.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class SignupUsecase {
  final SignUpRepostories signUpRepostories;

  SignupUsecase({required this.signUpRepostories});

  Future<Either<Failure, Unit>> signup({
    required SignupEntites signupentities,
  }) async {
    return await signUpRepostories.signup(signupentities: signupentities);
  }

  Future<Either<Failure, String>> uploadImage(
      {required XFile? profilepic}) async {
    return await signUpRepostories.uploadImage(profilepic: profilepic);
  }
}
