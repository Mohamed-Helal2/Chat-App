import 'dart:io';

import 'package:chatapp/features/signup/data/model/signup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

abstract class SignupRemoteDataSource {
  Future<Unit> signup(SignupModel signupmodel);
  Future<String> uploadImage(XFile? profilePic);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  @override
  Future<Unit> signup(SignupModel signupmodel) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: signupmodel.email, password: signupmodel.password);
    await userCredential.user!.updateProfile(
      displayName: signupmodel.name,
      photoURL: signupmodel.photourl,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': signupmodel.email,
      'name': signupmodel.name,
      'photoUrl': signupmodel.photourl,
      'uid': userCredential.user!.uid,
      'status':signupmodel.status
    });
    return unit;
  }

  @override
  Future<String> uploadImage(XFile? profilePic) async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String imageName = "${basename(profilePic!.path)}_$timestamp";
    final storageRef =
        FirebaseStorage.instance.ref("users profile photo/$imageName");
    await storageRef.putFile(File(profilePic.path));
    String url = await storageRef.getDownloadURL();
    return url;
  }
}
