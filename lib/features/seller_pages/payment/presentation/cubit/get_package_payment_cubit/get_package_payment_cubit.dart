import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/get_package_model.dart';
import '../../../domain/usecase/get_package_usecase.dart';

part 'get_package_payment_state.dart';

class GetPackagePaymentCubit extends Cubit<GetPackagePaymentState> {
  GetPackagePaymentCubit({
    required this.getPaymentPackageUseCase,
  }) : super(GetPackagePaymentInitial());

  final GetPaymentPackageUseCase getPaymentPackageUseCase;
  List<CardPayment> card = [];
  List<UserPackage> packages = [];
  Future<void> fGetPaymentPackage(GetPackageParms) async {
    emit(GetPaymentLoading());
    final response = await getPaymentPackageUseCase(GetPackageParms);

    response.fold(
      (failure) => emit(ErrorGetPayment()),
      (success) {
        log(success.toString());
        card = success.cards;
        packages = success.packages;
        emit(SucessGetPayment(getPackageAndCardModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
