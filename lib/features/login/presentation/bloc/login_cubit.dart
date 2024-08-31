import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/login/domain/entites/login_entities.dart';
import 'package:chatapp/features/login/domain/usecases/login_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUsecases}) : super(LoginInitial());
  final LoginUsecases loginUsecases;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> loginformkey = GlobalKey();
  login() async {
    emit(LoadingLoginState());
    LoginEntities loginEntities = LoginEntities(
        email: emailcontroller.text, password: passwordcontroller.text);
    final response = await loginUsecases.login(loginEntities);
    response.fold(
      (l) {
        print('fail-------------- ${_mapFailutrToMessage(l)}');
        emit(FailureLoginState(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        print("sucess ------ $r");
        emit(SucessLoginState());
      },
    );
  }

  bool isobescurepassword = true;
  isobsecure() {
    isobescurepassword = !isobescurepassword;
    print("------ $isobescurepassword");
    emit(paswwordstate(isobescure: isobescurepassword));
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
