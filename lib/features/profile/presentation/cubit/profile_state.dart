part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class Profileloadingstate extends ProfileState {}

final class ProfileSucessState extends ProfileState {
  final ProfileEntites profileentites;
const  ProfileSucessState({required this.profileentites});
}

final class ProfileFailureState extends ProfileState {
  final String errormessage;

 const ProfileFailureState({required this.errormessage});
  
}
