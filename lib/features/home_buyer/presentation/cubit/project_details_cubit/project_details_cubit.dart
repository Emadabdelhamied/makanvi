import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/get_project_details_usecase.dart';
import 'dart:ui' as ui;

import '../../../../../core/error/failures.dart';
import '../../../data/models/project_model.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit({required this.getProjectUseCase})
      : super(ProjectDetailsInitial());
  final GetProjectUseCase getProjectUseCase;
  Future<void> fGetProject({required int id}) async {
    emit(ProjectLoadingState());
    final response = await getProjectUseCase(ProjectParams(id: id));

    response.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(ProjectErrorState(message: failure.message));
      },
      (success) {
        emit(ProjectSuccess(project: success.project));
      },
    );
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
