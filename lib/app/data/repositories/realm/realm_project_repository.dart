import 'package:flutter_clean_arch/app/data/repositories/realm/models/project_model.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:flutter_clean_arch/app/interactor/exceptions/exceptions.dart';
import 'package:flutter_clean_arch/app/interactor/repositories/project_repository.dart';
import 'package:realm/realm.dart';
import 'package:result_dart/result_dart.dart';

import 'adapters/project_adapter.dart';

Realm initializeRealm() {
  var config = Configuration.local(
    [ProjectModel.schema],
    path: './db.realm',
  );
  var realm = Realm(config);
  return realm;
}

class RealmProjectRepository implements ProjectRepository {
  final Realm realm;

  RealmProjectRepository(this.realm);

  @override
  AsyncResult<List<ProjectEntity>, ProjectException> getProjects() async {
    try {
      var projects = realm.all<ProjectModel>();
      final entities = projects.map(ProjectAdapter.fromModel).toList();
      return Success(entities);
    } on RealmException catch (e) {
      return Failure(ProjectException(e.toString()));
    }
  }

  @override
  AsyncResult<ProjectEntity, ProjectException> putProject(ProjectEntity project) async {
    try {
      var model = ProjectAdapter.fromEntity(project);
      realm.write(() {
        realm.add(model, update: true);
      });
      return Success(project);
    } on RealmException catch (e) {
      return Failure(ProjectException(e.toString()));
    }
  }

  @override
  AsyncResult<ProjectEntity, ProjectException> deleteProject(ProjectEntity project) async {
    try {
      var model = ProjectAdapter.fromEntity(project);
      realm.write(() {
        realm.delete(model);
      });
      return Success(project);
    } on RealmException catch (e) {
      return Failure(ProjectException(e.toString()));
    }
  }
}
