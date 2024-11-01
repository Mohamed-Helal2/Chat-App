import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/signup/domain/entites/signup_entites.dart';
import 'package:chatapp/features/signup/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.signupUsecase}) : super(SignupInitial());
  final SignupUsecase signupUsecase;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  GlobalKey<FormState> signupformkey = GlobalKey();
  bool isobescurepassword = true;
  bool isobescureConfirmpassword = true;
  XFile? profilePic;
  String? photourl;
  signup() async {
    emit(LoadingSignupState());
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      emit(const FailureSignupState(
          errorMessage: ErroStrings.passwordesnotSame));
    } else {
      if (profilePic != null) {
        final response =
            await signupUsecase.uploadImage(profilepic: profilePic);
        response.fold(
          (l) {
            emit(FailureSignupState(errorMessage: _mapFailutrToMessage(l)));
          },
          (r) async {
            photourl = r;
          },
        );
      }
      SignupEntites signupEntites = SignupEntites(
          email: emailcontroller.text,
          password: passwordcontroller.text,
          name: namecontroller.text,
          photourl: photourl,
          status: null);
      final response = await signupUsecase.signup(
        signupentities: signupEntites,
      );
      response.fold(
        (l) {
          emit(FailureSignupState(errorMessage: _mapFailutrToMessage(l)));
        },
        (r) async {
          emit(SucessSignupState());
        },
      );
      //}
    }
  }

  pickImage() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      if (value != null) {
        profilePic = value;
      }
    });
    if (profilePic != null) {
      emit(PickImageSucess(profilePic: profilePic!));
    }
  }

  isobsecurepassword() {
    isobescurepassword = !isobescurepassword;
    emit(Paswwordstate(isobescure: isobescurepassword));
  }

  isobsecureConfirmpassword() {
    isobescureConfirmpassword = !isobescureConfirmpassword;
    emit(Paswwordstate(isobescure: isobescureConfirmpassword));
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
