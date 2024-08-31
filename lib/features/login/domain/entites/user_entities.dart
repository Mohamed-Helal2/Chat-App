import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String id;
  final String? name;
  final String? photourl;
  final String email;
  const UserEntities(
      {required this.id,
        this.name,
      this.photourl,
      required this.email});

  @override
  List<Object?> get props => [id, name, photourl, email];
}
