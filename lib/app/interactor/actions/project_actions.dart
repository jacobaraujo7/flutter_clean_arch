import 'dart:async';
import 'dart:io';

import 'package:flutter_clean_arch/app/core/extensions/value_notifier_extensions.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../../injector.dart';
import '../repositories/project_repository.dart';
import '../services/choose_directory_service.dart';
import '../services/git_service.dart';
import '../services/launcher_service.dart';
import '../states/project_states.dart';

Timer? _timer;

void listenGitStatus() async {
  _timer?.cancel();
  await _executeGitStatusInAllProject();

  _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    _executeGitStatusInAllProject();
  });
}

Future<void> _executeGitStatusInAllProject() async {
  final projects = projectsState.value.toList();
  for (final project in projects) {
    await updateProjectGitStatus(project);
  }
}

Future<void> fetchAllProject() async {
  projectLoadingState.setValue(true);
  final repository = injector.get<ProjectRepository>();
  await repository
      .getProjects() //
      .fold(
        projectsState.setValue,
        projectErrorState.setValue,
      );

  projectLoadingState.setValue(false);
}

Future<void> putProject(ProjectEntity project) async {
  final repository = injector.get<ProjectRepository>();

  await repository
      .putProject(project) //
      .map(_updateProjects)
      .fold(
        projectsState.setValue,
        projectErrorState.setValue,
      );
}

List<ProjectEntity> _updateProjects(ProjectEntity updatedProject) {
  final projects = projectsState.value.toList();
  final index = projects.indexWhere((p) => p.directory.path == updatedProject.directory.path);
  if (index != -1) {
    projects[index] = updatedProject;
  } else {
    projects.add(updatedProject);
  }
  return projects;
}

Future<void> deleteProject(ProjectEntity project) async {
  final repository = injector.get<ProjectRepository>();
  await repository
      .deleteProject(project) //
      .map(_removeProject)
      .fold(
        projectsState.setValue,
        projectErrorState.setValue,
      );
}

List<ProjectEntity> _removeProject(ProjectEntity deletedProject) {
  final projects = projectsState.value.toList();
  projects.removeWhere((p) => p.directory.path == deletedProject.directory.path);
  return projects;
}

Future<void> updateProjectGitStatus(ProjectEntity project) async {
  final repository = injector.get<GitService>();
  final status = await repository.getStatus(project.directory);
  final updatedProject = project.copyWith(gitStatus: status);
  await putProject(updatedProject);
}

void openProject(ProjectEntity project) {
  final repository = injector.get<LauncherService>();
  repository.launch(project.directory);
}

Future<Directory> selectProject() async {
  final repository = injector.get<ChooseDirectoryService>();
  final path = await repository.select();

  if (path == null) {
    return Directory('');
  }
  return Directory(path);
}
