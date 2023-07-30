import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/project_model.dart';
import '../repositories/home_buyer_repositories.dart';

class GetProjectUseCase extends UseCase<ProjectModel, ProjectParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetProjectUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, ProjectModel>> call(ProjectParams parms) async {
    return await homeBuyerRepository.getProjectDetails(parms: parms);
  }
}

class ProjectParams {
  final int id;

  ProjectParams({required this.id});
}
