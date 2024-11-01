import 'package:chatapp/features/mychats/data/model/mychats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyChatsRemoteDataSource {
  Stream<List<MyChatsModel>> getallMychats({required String myid});
}

class MyChatsRemoteDataSourceImpl implements MyChatsRemoteDataSource {
  @override
  Stream<List<MyChatsModel>> getallMychats({required String myid}) {
    return FirebaseFirestore.instance
        .collection('chats')
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((doc) => (doc.data()['participants'] as Map<String, dynamic>)
              .containsKey(myid))
          .map((doc) {
        return MyChatsModel.fromJson(doc.data());
      }).toList();
    });
  }
}
