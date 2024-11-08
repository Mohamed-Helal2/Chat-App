import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/home/domain/usecases/get_all_user_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
       filteredUsers = allusers
          .where(
              (user) => user.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      emit(SucessUsersState(allusers: filteredUsers));
    } else {
       emit(SucessUsersState(allusers: allusers));
    }
  }

  refreshuser() async {
     emit(LoadingUsersState());
    final response = await getAllUserUsecase.getAllUaer();
    response.fold(
      (l) {
 
        emit(FailureUsersStet(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
 
        emit(SucessUsersState(allusers: r));
      },
    );
  }

  Future<void> setUserInChatStatus(String chatId) async {
    final userid = FirebaseAuth.instance.currentUser!.uid;

    final mchatid = _generateChatId(chatId, userid);
    await FirebaseFirestore.instance.collection('chats').doc(mchatid).update({
      'participants.$userid.isInChat': false, 
    });
  }

  String _generateChatId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join();
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
