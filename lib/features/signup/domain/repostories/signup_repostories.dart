import 'package:chatapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../entites/signup_entites.dart';

abstract class SignUpRepostories {
  Future<Either<Failure, Unit>> signup(
      {required SignupEntites signupentities});
  Future<Either<Failure, String>> uploadImage({required XFile? profilepic});
}
