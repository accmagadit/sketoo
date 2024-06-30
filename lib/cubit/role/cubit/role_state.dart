part of 'role_cubit.dart';

class RoleState extends Equatable {
  final bool isAnakOrangTua;
  const RoleState({this.isAnakOrangTua = false});

  @override
  List<Object> get props => [isAnakOrangTua];
}

final class RoleInitial extends RoleState {}
