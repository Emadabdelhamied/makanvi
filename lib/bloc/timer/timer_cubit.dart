import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  static TimerCubit get(BuildContext context) => BlocProvider.of(context);
  int start = 60;
  bool timerVisibility = true;
  var oneSec = const Duration(seconds: 1);

  String twoDigits(int number) => number.toString().padLeft(2, '0');

  void startTimer() {
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 1) {
          timer.cancel();
          emit(TimerEnd());
          start = 60;
        } else {
          emit(TimerStart());
          start--;
        }
      },
    );
  }
}
