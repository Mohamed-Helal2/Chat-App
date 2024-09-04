import 'package:equatable/equatable.dart';

class UserEntites extends Equatable {
  final String name;
  final String? status;
  final String? photourl;
  final String id;
  final String email;

  UserEntites(
      {required this.name,
        this.status,
        this.photourl,
      required this.id,
      required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [name,status,photourl,id,email];
}
