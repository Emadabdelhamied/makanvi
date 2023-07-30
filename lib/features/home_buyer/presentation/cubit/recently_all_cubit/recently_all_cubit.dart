import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/get_feature_all_usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../data/models/recently_all_model.dart';
import '../../../domain/usecase/get_recntly_all_usecase.dart';
import 'dart:ui' as ui;

part 'recently_all_state.dart';

class RecentlyAllCubit extends Cubit<RecentlyAllState> {
  RecentlyAllCubit({required this.getRecentlyAllUseCase})
      : super(RecentlyAllInitial());
  final GetRecentlyAllUseCase getRecentlyAllUseCase;
  bool isMore = true;
  int currentpage = 1;
  List<RecentlyAllData> recentlyDataList = [];
  Future<void> fGetRecentlyAll({
    bool? isFirst,
  }) async {
    if (isFirst ?? false) {
      currentpage = 1;
    }
    if (isMore) {
      if (currentpage == 1) {
        emit(GetRecentlyAllLoading());
        recentlyDataList = [];
      } else {
        emit(GetRecentlyAllPaginationLoading());
      }

      final failOrResponse =
          await getRecentlyAllUseCase(PaginationParams(page: currentpage));
      failOrResponse.fold(
        (l) {
          if (l is ServerFailure) {
            emit(ErrorGetRecentlyAll(message: l.message));
          }
        },
        (r) {
          if (r.recently.meta.to != null && r.recently.data.isNotEmpty) {
            currentpage++;
          } else {
            isMore = false;
          }

          recentlyDataList += r.recently.data;
          emit(SucessGetRecentlyAll(recentlyAllModel: r));
        },
      );
    }
  }

  Uint8List? markerIcon;
  Future<Uint8List> getBytesFromAsset() async {
    ByteData data = await rootBundle.load('assets/images/markerImage.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
    return markerIcon!;
  }
}
