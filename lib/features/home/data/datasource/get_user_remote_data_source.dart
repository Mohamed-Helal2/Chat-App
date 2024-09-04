import 'package:chatapp/features/home/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetUserRemoteDataSource {
  Future<List<UsersModel>> getAllusers();
}

class GetUserRemoteDataSourceImple implements GetUserRemoteDataSource {
  @override
  Future<List<UsersModel>> getAllusers() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final List<UsersModel> allUsers = querySnapshot.docs.map((doc) {
      return UsersModel.fromjson(doc.data());
    }).toList();
    return allUsers;
  }
}
