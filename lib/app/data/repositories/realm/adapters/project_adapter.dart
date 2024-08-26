import 'dart:io';

import 'package:flutter_clean_arch/app/data/repositories/realm/models/project_model.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';

abstract class ProjectAdapter {
  static ProjectEntity fromModel(ProjectModel model) {
    return ProjectEntity(
      directory: Directory(model.path),
      name: model.name,
      description: model.description,
      gitStatus: model.gitStatus,
    );
  }

  static ProjectModel fromEntity(ProjectEntity entity) {
    return ProjectModel(
      entity.directory.path,
      entity.name,
      entity.description,
      entity.gitStatus,
    );
  }
}
