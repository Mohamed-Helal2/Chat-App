import 'package:chatapp/features/home/domain/entities/user_entites.dart';

class UsersModel extends UserEntites {
  UsersModel(
      {required super.name,
      super.status,
      super.photourl,
      required super.id,
      required super.email});
  factory UsersModel.fromjson(Map<String, dynamic> json) {
    return UsersModel(
        name: json['name'],
        status: json['status'],
        photourl: json['photoUrl'],
        id: json['uid'],
        email: json['email']);
  }
  Map<String, dynamic> tojson() => {
        'email': email,
        'name': name,
        'photoUrl': photourl,
        'uid': id,
        'status': status
      };
}
