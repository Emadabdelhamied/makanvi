import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_name_rent_or_sell_state.dart';

class ChangeNameRentOrSellCubit extends Cubit<ChangeNameRentOrSellState> {
  ChangeNameRentOrSellCubit() : super(ChangeNameRentOrSellInitial());

  String _hint = "";
  String get hint => _hint;
  set setHint(String val) {
    _hint = val;
    emit(NameRentOrSell(message: val));
    emit(ChangeNameRentOrSellInitial());
  }
}
