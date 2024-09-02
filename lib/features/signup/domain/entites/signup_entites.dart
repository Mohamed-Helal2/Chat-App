import 'package:equatable/equatable.dart';

class SignupEntites extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? photourl;
  final String? userid;

  const SignupEntites(
      {required this.email,
      required this.password,
      required this.name,
        this.photourl,
        this.userid});

  @override
  List<Object?> get props => [email, name, photourl, userid, password];
}
