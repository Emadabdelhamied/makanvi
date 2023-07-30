import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/settings/data/models/profile_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/domain/entities/register_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUsecase,
  }) : super(ProfileInitial());
  final GetProfileUsecase getProfileUsecase;

  Future<void> fGetProfile() async {
    emit(ProfileLoadingState());
    final response = await getProfileUsecase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          log(failure.message);
          emit(ProfileErrorState(message: failure.message));
        }
      },
      (success) {
        emit(ProfileLoadedState(user: success));
      },
    );
  }
}
