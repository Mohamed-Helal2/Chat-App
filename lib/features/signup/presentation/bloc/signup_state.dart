part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class LoadingSignupState extends SignupState {}

final class FailureSignupState extends SignupState {
  final String errorMessage;

  const FailureSignupState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class SucessSignupState extends SignupState {
  @override
  List<Object> get props => [];
}

final class Paswwordstate extends SignupState {
  final bool isobescure;
  const Paswwordstate({required this.isobescure});
  @override
  List<Object> get props => [isobescure];
}

final class ConfirmPaswwordstate extends SignupState {
  final bool isobescure;
  const ConfirmPaswwordstate({required this.isobescure});
  @override
  List<Object> get props => [isobescure];
}

final class Uploadprofilestate extends SignupState {}

final class PickImageLoading extends SignupState {}

final class PickImageSucess extends SignupState {
  final XFile profilePic;

  const PickImageSucess({required this.profilePic});
  @override
  List<Object> get props => [profilePic];
}
