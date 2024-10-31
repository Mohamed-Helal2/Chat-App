import 'package:chatapp/features/profile/data/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getprofiledata({required String id});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileModel> getprofiledata({required String id}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final profilemodel = ProfileModel.fromjson(documentSnapshot.data()!);
    return profilemodel;
  }
}
