
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:chatapp/features/mychats/domain/repostories/mychats_repostories.dart';
import 'package:dartz/dartz.dart';

class GetMychatsUsecase {
  final MychatsRepostories mychatsRepostories;

  GetMychatsUsecase({required this.mychatsRepostories});

  Stream<Either<Failure, List<MychatsEntities>>> getmychats({required String userid}) {
    return mychatsRepostories.getMychats(userid: userid);
  }
}
