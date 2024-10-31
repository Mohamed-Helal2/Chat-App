import 'package:equatable/equatable.dart';

class ProfileEntites extends Equatable {
  final String name;
  final String email;
  final String id;
  final String? status;
  final String? photourl;

  ProfileEntites(
      {required this.name,
      required this.email,
      required this.id,
      this.status,
      this.photourl});

  @override
   List<Object?> get props => [name, email, id, status, photourl];
}
