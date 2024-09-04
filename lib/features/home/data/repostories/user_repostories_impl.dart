import 'package:chatapp/core/error/exception.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/home/data/datasource/get_user_local_data_source.dart';
import 'package:chatapp/features/home/data/datasource/get_user_remote_data_source.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/domain/repostories/user_repostories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserRepostoriesImpl implements UserRepostories {
  final GetUserRemoteDataSource getUserRemoteDataSource;
  final GetUserLocalDataSource getUserLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepostoriesImpl(
      {required this.getUserRemoteDataSource,
      required this.networkInfo,
      required this.getUserLocalDataSource});
  @override
  Future<Either<Failure, List<UserEntites>>> getAllUaer() async {
    if (await networkInfo.isconnected) {
      try {
        final allusers = await getUserRemoteDataSource.getAllusers();
        getUserLocalDataSource.cachedusers(allusers);
        return right(allusers);
      } on FirebaseException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      try {
        final localusers = await getUserLocalDataSource.getcachedusers();
        return right(localusers);
      } on EmptyUserException {
        return left(EmptyUserFailure());
      }
    }
  }
}
