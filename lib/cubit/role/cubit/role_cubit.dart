import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(RoleInitial());

  void isOrangtua(bool isAnakOrangTua) {
    emit(RoleState(isAnakOrangTua: isAnakOrangTua));
  }
}
