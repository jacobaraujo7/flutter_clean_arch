import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../exceptions/exceptions.dart';

abstract class ProjectRepository {
  AsyncResult<List<ProjectEntity>, ProjectException> getProjects();

  AsyncResult<ProjectEntity, ProjectException> putProject(ProjectEntity project);

  AsyncResult<ProjectEntity, ProjectException> deleteProject(ProjectEntity project);
}
