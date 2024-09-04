part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class LoadingUsersState extends UsersState {}

final class SucessUsersState extends UsersState {
  final List<UserEntites> allusers;

  const SucessUsersState({required this.allusers});
  @override
  List<Object> get props => [allusers];
}

final class FailureUsersStet extends UsersState {
  final String errorMessage;

  const FailureUsersStet({required this.errorMessage});
    @override
  List<Object> get props => [errorMessage];
  
}
