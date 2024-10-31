import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/profile/data/datasouce/profile_remote_data_source.dart';
import 'package:chatapp/features/profile/domain/entites/profile_entites.dart';
import 'package:chatapp/features/profile/domain/repostories/profile_repo.dart';
import 'package:dartz/dartz.dart';

class ProfileRepoImpl implements Profilerepo {
  final ProfileRemoteDataSource getprofileremoteDatasource;
  final NetworkInfo networkInfo;

  ProfileRepoImpl({required this.getprofileremoteDatasource,required this.networkInfo});
  @override
  Future<Either<Failure, ProfileEntites>> profiledata(
      {required String userid}) async {
    if (await networkInfo.isconnected) {
      final profiledata =
          await getprofileremoteDatasource.getprofiledata(id: userid);
      return right(profiledata);
    } else {
      return left(OffLineFailure());
    }
  }
}
