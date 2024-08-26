// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ProjectModel extends _ProjectModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectModel(
    String path,
    String name,
    String description,
    String gitStatus,
  ) {
    RealmObjectBase.set(this, 'path', path);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'gitStatus', gitStatus);
  }

  ProjectModel._();

  @override
  String get path => RealmObjectBase.get<String>(this, 'path') as String;
  @override
  set path(String value) => RealmObjectBase.set(this, 'path', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get gitStatus =>
      RealmObjectBase.get<String>(this, 'gitStatus') as String;
  @override
  set gitStatus(String value) => RealmObjectBase.set(this, 'gitStatus', value);

  @override
  Stream<RealmObjectChanges<ProjectModel>> get changes =>
      RealmObjectBase.getChanges<ProjectModel>(this);

  @override
  Stream<RealmObjectChanges<ProjectModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ProjectModel>(this, keyPaths);

  @override
  ProjectModel freeze() => RealmObjectBase.freezeObject<ProjectModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'path': path.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
      'gitStatus': gitStatus.toEJson(),
    };
  }

  static EJsonValue _toEJson(ProjectModel value) => value.toEJson();
  static ProjectModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'path': EJsonValue path,
        'name': EJsonValue name,
        'description': EJsonValue description,
        'gitStatus': EJsonValue gitStatus,
      } =>
        ProjectModel(
          fromEJson(path),
          fromEJson(name),
          fromEJson(description),
          fromEJson(gitStatus),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ProjectModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ProjectModel, 'ProjectModel', [
      SchemaProperty('path', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('gitStatus', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
