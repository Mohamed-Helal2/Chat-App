import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/profile/domain/entites/profile_entites.dart';
import 'package:chatapp/features/profile/domain/usecases/profile_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/erro_strings.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileUseCase}) : super(ProfileInitial());
  final ProfileUseCase profileUseCase;

  profiledata({required String userid}) async {
    emit(Profileloadingstate());
    final response = await profileUseCase.profiledata(userid: userid);
    response.fold(
      (l) {
        emit(ProfileFailureState(errormessage: _mapFailutrToMessage(l)));
      },
      (r) {
        emit(ProfileSucessState(profileentites: r));
      },
    );
  }

  String _mapFailutrToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case FirebaseFailure:
        return (failure as FirebaseFailure).message ??
            'Unexpected Firebase Error';
      case OffLineFailure:
        return ErroStrings.offlineFailure;
      default:
        return 'Un Expected Error';
    }
  }
}
