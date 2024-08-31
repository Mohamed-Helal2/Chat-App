part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoadingLoginState extends LoginState {}

final class FailureLoginState extends LoginState {
  final String errorMessage;

  const FailureLoginState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class SucessLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

final class paswwordstate extends LoginState {
  final bool isobescure;

  const paswwordstate({required this.isobescure});
  @override
  List<Object> get props => [isobescure];
}
