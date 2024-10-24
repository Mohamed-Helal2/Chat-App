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


class EmptyUserFailure extends Failure {
 
  EmptyUserFailure();

  @override
  List<Object?> get props => [];
}

class EmptyMessageFailure extends Failure {
 
  EmptyMessageFailure();

  @override
  List<Object?> get props => [];
}
// location
class LocationServiceFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationPermissionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// pdf failure 
class getpdfFailure extends Failure {
  @override
  List<Object?> get props => [];
}