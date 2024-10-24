import 'package:chatapp/features/signup/domain/entites/signup_entites.dart';

class SignupModel extends SignupEntites {
 const SignupModel(
      {required super.email,
      required super.password,
      required super.name,
      super.photourl,
      required super.userid,
      super.status
      });

  factory SignupModel.fromjson(Map<String, dynamic> json) {
    return SignupModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        photourl: json['photoUrl'] ,
        userid: json['uid'],
        status: json['status'],
        );
  }
}
