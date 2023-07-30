import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/error/failures.dart';

import '../../../../core/usecases/usecases.dart';
import '../../data/models/favourite_model.dart';
import '../../domain/usecases/favourite_usecase.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.favouritesUseCase}) : super(FavouriteInitial());
  final FavouritesUseCase favouritesUseCase;
  int len = 0;
  Future<void> fGetFavourite({bool isPulled = false}) async {
    len = 0;

    emit(FavouriteLoadingState());

    final response = await favouritesUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(FavouriteErrorState(message: failure.message));
        }
      },
      (success) {
        len = success.all.length;
        emit(FavouriteSuccess(success: success));
      },
    );
  }
}
