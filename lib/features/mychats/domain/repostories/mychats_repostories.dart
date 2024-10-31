import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:dartz/dartz.dart';

abstract class MychatsRepostories {
  Stream<Either<Failure, List<MychatsEntities>>> getMychats({
    required String userid
  });
}
