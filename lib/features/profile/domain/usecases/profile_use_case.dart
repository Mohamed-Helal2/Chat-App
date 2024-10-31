import 'package:chatapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entites/profile_entites.dart';
import '../repostories/profile_repo.dart';

class ProfileUseCase {
  final Profilerepo profilerepo;

  ProfileUseCase({required this.profilerepo});

  Future<Either<Failure, ProfileEntites>> profiledata({required String userid}) async {
    return await profilerepo.profiledata(userid: userid);
  }
}
