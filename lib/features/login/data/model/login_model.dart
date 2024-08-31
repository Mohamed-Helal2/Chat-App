import 'package:chatapp/features/login/domain/entites/login_entities.dart';

class LoginModel extends LoginEntities {
  const LoginModel({required super.email, required super.password});
  factory LoginModel.fromjson(Map<String, dynamic> jsondata) {
    return LoginModel(email: jsondata['email'], password: jsondata['password']);
  }

  Map<String, dynamic> tojson() => {'email': email, 'password': password};
}
