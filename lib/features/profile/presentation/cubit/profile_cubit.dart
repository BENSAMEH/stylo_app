import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/profile_repository_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepositoryImpl repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  UserModel? user;

  Future<void> getCurrentUser() async {
    emit(ProfileLoading());

    try {
      user = await repository.getCurrentUser();

      if (user != null) {
        emit(ProfileSuccess(user!));
      } else {
        emit(ProfileFailure("User not found"));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
