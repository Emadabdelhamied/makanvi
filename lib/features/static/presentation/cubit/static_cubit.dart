import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/static/domain/usecases/contact_us.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/abou_us_usecase.dart';
import '../../domain/usecases/privacy_and_policy_use_case.dart';
import '../../domain/usecases/terms_and_conditions_usecase.dart';

part 'static_state.dart';

class StaticCubit extends Cubit<StaticState> {
  StaticCubit(
      {required this.aboutUsUseCase,
      required this.contactWithUsUseCase,
      required this.privacyAndPolicyUseCase,
      required this.termsAndConditionsUseCase})
      : super(StaticInitial());
  final PrivacyAndPolicyUseCase privacyAndPolicyUseCase;
  final TermsAndConditionsUseCase termsAndConditionsUseCase;
  final AboutUsUseCase aboutUsUseCase;
  final ContactWithUsUseCase contactWithUsUseCase;
  Future<void> fGetAboutUs() async {
    emit(StaticPagesLoadingState());
    final response = await aboutUsUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(StaticPagesErrorState(message: failure.message));
        }
      },
      (success) {
        emit(StaticPagesSuccessState(message: success));
      },
    );
  }

  Future<void> fGetTerms() async {
    emit(StaticPagesLoadingState());
    final response = await termsAndConditionsUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(StaticPagesErrorState(message: failure.message));
        }
      },
      (success) {
        emit(StaticPagesSuccessState(message: success));
      },
    );
  }

  Future<void> fGetPrivacy() async {
    emit(StaticPagesLoadingState());
    final response = await privacyAndPolicyUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(StaticPagesErrorState(message: failure.message));
        }
      },
      (success) {
        emit(StaticPagesSuccessState(message: success));
      },
    );
  }

  Future<void> fEmailUs(
      {required ContactWithUsParams contactWithUsParams}) async {
    emit(StaticPagesLoadingState());
    final response = await contactWithUsUseCase(contactWithUsParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(StaticPagesErrorState(message: failure.message));
        }
      },
      (success) {
        emit(StaticPagesSuccessState(message: success));
      },
    );
  }
}
