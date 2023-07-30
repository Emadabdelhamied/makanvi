import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitState());

  static ConnectivityCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Connectivity connection = Connectivity();
  ConnectivityResult? connectionResult;
  // AppLoadingButtonController connectivityController =
  //     AppLoadingButtonController();

  getConnectivity() async {
    connectionResult = await connection.checkConnectivity();
    emit(CheckConnectivityState());
  }
}
