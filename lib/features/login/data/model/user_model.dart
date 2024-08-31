import 'package:chatapp/features/login/domain/entites/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      super.photourl});

  factory UserModel.fromjson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['id'],
        name: jsonData['name'],
        email: jsonData['email'],
        photourl: jsonData['photourl']);
  }

  Map<String, dynamic> tojson() =>
      {'id': id, 'name': name, 'email': email, 'photourl': photourl};
}
