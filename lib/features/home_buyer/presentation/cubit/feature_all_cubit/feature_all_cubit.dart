import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/feature_all_model.dart';
import '../../../domain/usecase/get_feature_all_usecase.dart';
import 'dart:ui' as ui;
part 'feature_all_state.dart';

class FeatureAllCubit extends Cubit<FeatureAllState> {
  FeatureAllCubit({required this.getFeatureAllUseCase})
      : super(FeatureAllInitial());

  final GetFeatureAllUseCase getFeatureAllUseCase;
  bool isMore = true;
  int currentpage = 1;
  List<FeatureAllData> featuredDtaList = [];
  Future<void> fGetAllFeature({
    bool? isFirst,
  }) async {
    isMore = isFirst ?? isMore;
    if (isFirst ?? false) {
      currentpage = 1;
    }
    if (isMore) {
      if (currentpage == 1) {
        emit(GetFeatureAllLoading());
        featuredDtaList = [];
      } else {
        emit(GetFeatureAllPaginationLoading());
      }
      final failOrResponse =
          await getFeatureAllUseCase(PaginationParams(page: currentpage));
      failOrResponse.fold(
        (l) {
          if (l is ServerFailure) {
            emit(ErrorGetFeatureAll(message: l.message));
          }
        },
        (r) {
          //((r.featured.meta.to! / 15).ceil() > currentpage)
          if (r.featured.meta.to != null && r.featured.data.isNotEmpty) {
            currentpage++;
          } else {
            isMore = false;
          }

          featuredDtaList += r.featured.data;
          emit(SucessGetFeatureAll(featureAllModel: r));
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
