import 'package:chatapp/features/profile/domain/entites/profile_entites.dart';

class ProfileModel extends ProfileEntites {
  ProfileModel(
      {required super.name,
      required super.email,
      required super.id,
      super.photourl,
      super.status});

  factory ProfileModel.fromjson(Map<String, dynamic> jsondata) {
    return ProfileModel(
      name: jsondata['name'],
      email: jsondata['email'],
      id: jsondata['uid'],
      photourl: jsondata['photoUrl'],
      status: jsondata['status'],
    );
  }
  Map<String, dynamic> tofirestore() => {
        'email': email,
        'name': name,
        'id': id,
        'photoUrl': photourl,
        'status': status
      };
}
