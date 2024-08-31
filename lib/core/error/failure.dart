import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OffLineFailure extends Failure {
 
  OffLineFailure();

  @override
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure {
  final String? message;
  WrongDataFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class FirebaseFailure extends Failure {
  final String? message;

  FirebaseFailure({this.message});

  @override
  List<Object?> get props => [message];
}
