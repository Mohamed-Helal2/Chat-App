part of 'allmychats_cubit.dart';

sealed class AllmychatsState extends Equatable {
  const AllmychatsState();

  @override
  List<Object> get props => [];
}

final class AllmychatsInitial extends AllmychatsState {}

final class AllmychatsLoading extends AllmychatsState {}

final class AllmychatsSucess extends AllmychatsState {
  final List<MychatsEntities> allmychats;

  const AllmychatsSucess({required this.allmychats});
}

final class AllmychatsFailure extends AllmychatsState {
  final String error_message;

  const AllmychatsFailure({required this.error_message});
}

final class streamState extends AllmychatsState {}
