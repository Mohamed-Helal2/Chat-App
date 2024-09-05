import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/domain/usecases/get_all_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({required this.getAllUserUsecase}) : super(UsersInitial());
  final GetAllUserUsecase getAllUserUsecase;
  TextEditingController searchcontroller = TextEditingController();
  List<UserEntites> filteredUsers = [];
  List<UserEntites> allusers = [];
  final String test = "test";
  getalluser() async {
    emit(LoadingUsersState());
    final response = await getAllUserUsecase.getAllUaer();
    response.fold(
      (l) {
        emit(FailureUsersStet(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        allusers = r;
        emit(SucessUsersState(allusers: r));
      },
    );
  }

  filteruser({required String value}) {
    if (searchcontroller.text.isNotEmpty) {
      print("-----11");
      filteredUsers = allusers
          .where(
              (user) => user.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      emit(SucessUsersState(allusers: filteredUsers));
    } else {
      print("-----2");
      emit(SucessUsersState(allusers: allusers));
    }
  }

  refreshuser() async {
    print('------ refresh');
    emit(LoadingUsersState());
    final response = await getAllUserUsecase.getAllUaer();
    response.fold(
      (l) {
        print("---------- fail");

        emit(FailureUsersStet(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        print("---------- $r");

        emit(SucessUsersState(allusers: r));
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
