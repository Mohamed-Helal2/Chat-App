import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/mychats/data/datasource/my_chats_remote_data_source.dart';
import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:chatapp/features/mychats/domain/repostories/mychats_repostories.dart';
import 'package:dartz/dartz.dart';

class MychatsRepostoriesImpl implements MychatsRepostories {
  final MyChatsRemoteDataSource myChatsRemoteDataSource;
  final NetworkInfo networkInfo;

  MychatsRepostoriesImpl(
      {required this.myChatsRemoteDataSource, required this.networkInfo});

  @override
  Stream<Either<Failure, List<MychatsEntities>>> getMychats(
      {required String userid}) async* {
    if (await networkInfo.isconnected) {
      yield* myChatsRemoteDataSource.getallMychats(myid: userid).map(
        (chatModels) {
          List<MychatsEntities> allMyChats =
              chatModels.map((model) => model as MychatsEntities).toList();
          return right(allMyChats);
        },
      );
    } else {
      yield Left(OffLineFailure());
    }
  }
}
