import 'package:chatapp/features/login/data/model/login_model.dart';
import 'package:chatapp/features/login/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(LoginModel loginmodel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl();
  @override
  Future<UserModel> login(LoginModel loginmodel) async {
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginmodel.email, password: loginmodel.password);
    final User? firebaseUser = response.user;
    if (firebaseUser == null) {
      throw FirebaseAuthException;
    }
    final userModel = UserModel(
      id: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email!,
      photourl: firebaseUser.photoURL,
    );
    return userModel;
  }
}
