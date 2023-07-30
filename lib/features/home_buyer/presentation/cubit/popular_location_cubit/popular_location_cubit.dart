import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/get_feature_all_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/popular_location_model.dart';
import '../../../domain/usecase/get_popular_location_usecase.dart';

part 'popular_location_state.dart';

class PopularLocationCubit extends Cubit<PopularLocationState> {
  PopularLocationCubit({required this.getPopularLocationUseCase})
      : super(PopularLocationInitial());
  final GetPopularLocationUseCase getPopularLocationUseCase;
  bool isMore = true;
  int currentpage = 1;
  List<Datum> popularLocationList = [];
  Future<void> fGetPopularLocation({
    bool? isFirst,
  }) async {
    if (isFirst ?? false) {
      currentpage = 1;
    }
    if (isMore) {
      if (currentpage == 1) {
        emit(GetPopularLocationLoading());
        popularLocationList = [];
      } else {
        emit(GetPopularLocationPaginationLoading());
      }

      final failOrResponse =
          await getPopularLocationUseCase(PaginationParams(page: currentpage));
      failOrResponse.fold(
        (l) {
          if (l is ServerFailure) {
            emit(ErrorGetPopularLocation(message: l.message));
          }
        },
        (r) {
          //((r.popularLocations.meta.to! / 15).ceil() > currentpage)
          if (r.popularLocations.meta.to != null &&
              r.popularLocations.data.isNotEmpty) {
            currentpage++;
          } else {
            isMore = false;
          }

          popularLocationList += r.popularLocations.data;
          emit(SucessGetPopularLocation(popularLocationModel: r));
        },
      );
    }
  }
}
