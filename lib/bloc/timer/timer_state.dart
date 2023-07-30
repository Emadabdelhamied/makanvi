part of 'timer_cubit.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {}
class TimerStart extends TimerState {}
class TimerEnd extends TimerState {}
