
import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:chatapp/features/mychats/domain/usecases/get_mychats_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'allmychats_state.dart';

class AllmychatsCubit extends Cubit<AllmychatsState> {
  AllmychatsCubit({required this.getMychatsUsecase})
      : super(AllmychatsInitial());
  final GetMychatsUsecase getMychatsUsecase;

  void getallMyChats() {
    print("1 ---------------- enter");

    final userid = FirebaseAuth.instance.currentUser!.uid;
    print("22 ---------------- $userid");
    emit(AllmychatsLoading());

    getMychatsUsecase.getmychats(userid: userid).listen(
      (response) {
        print("sss ---- response");
        emit(streamState());
        response.fold(
          (l) {
            print("33 ---------------- $userid");

            emit(AllmychatsFailure(error_message: _mapFailutrToMessage(l)));
          },
          (r) {
            //    emit(AllmychatsLoading());
            print("44 ---------------- $r");

            emit(AllmychatsSucess(allmychats: r));
          },
        );
        //  emit(AllmychatsLoading());
      },
    );
    print("------------------------- eeend");
    // emit(streamState());
  }
   Future<void> setUserInChatStatus(String chatId) async {
    final userid = FirebaseAuth.instance.currentUser!.uid;

    final mchatid = _generateChatId(chatId, userid);
    // Update the user's isInChat status in the chat participants
    await FirebaseFirestore.instance.collection('chats').doc(mchatid).update({
      'participants.$userid.isInChat': false, // Accessing nested field
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
      case EmptyMessageFailure:
        return ErroStrings.emptymessagecachefailure;
      default:
        return 'Un Expected Error';
    }
  }
}
