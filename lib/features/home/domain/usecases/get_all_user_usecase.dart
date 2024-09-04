import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/domain/repostories/user_repostories.dart';
import 'package:dartz/dartz.dart';

class GetAllUserUsecase {
  final UserRepostories userRepostories;

  GetAllUserUsecase({required this.userRepostories});
  Future<Either<Failure, List<UserEntites>>> getAllUaer() async {
    return await userRepostories.getAllUaer();
  }
}
