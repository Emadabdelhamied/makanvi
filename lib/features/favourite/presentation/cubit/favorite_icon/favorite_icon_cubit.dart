import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/add_to_favorite_usecase.dart';
import '../../../domain/usecases/remove_all_favorites_usecase.dart';
import '../../../domain/usecases/remove_from_usecase.dart';

part 'favorite_icon_state.dart';

class FavoriteIconCubit extends Cubit<FavoriteIconState> {
  FavoriteIconCubit({
    required this.addToFavoritesUsecase,
    required this.removeFromFavoritesUsecase,
    required this.removeAllFavoritesUsecase,
  }) : super(FavoriteIconInitial());
  final AddToFavoritesUsecase addToFavoritesUsecase;
  final RemoveFromFavoritesUsecase removeFromFavoritesUsecase;
  final RemoveAllFavoritesUsecase removeAllFavoritesUsecase;
  Future<void> fAddToFavorites({required int id}) async {
    emit(FavoriteIconLoadingState());
    final failOrAdded =
        await addToFavoritesUsecase(AddToFavoritesParams(id: id));
    failOrAdded.fold(
      (fail) {
        if (fail is ServerFailure) {
          emit(FavoriteIconErrorState(message: fail.message));
        }
      },
      (added) {
        emit(FavoriteIconSuccessState(message: added));
      },
    );
  }

  Future<void> fRemoveFromFavorites({required int id}) async {
    emit(FavoriteIconLoadingState());
    final failOrRemoved =
        await removeFromFavoritesUsecase(AddToFavoritesParams(id: id));
    failOrRemoved.fold(
      (fail) {
        if (fail is ServerFailure) {
          emit(FavoriteIconErrorState(message: fail.message));
        }
      },
      (removed) {
        emit(FavoriteIconSuccessState(message: removed));
      },
    );
  }

  Future<void> fRemoveAllFavorites() async {
    emit(RemoveFavoriteLoadingState());
    final failOrRemoved = await removeAllFavoritesUsecase(NoParams());
    failOrRemoved.fold(
      (fail) {
        if (fail is ServerFailure) {
          emit(RemoveFavoriteErrorState(message: fail.message));
        }
      },
      (removed) {
        emit(RemoveFavoriteSuccessState(message: removed));
      },
    );
  }
}
