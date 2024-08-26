import 'dart:io';

import 'package:flutter_clean_arch/app/injector.dart';
import 'package:flutter_clean_arch/app/interactor/actions/project_actions.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:flutter_clean_arch/app/interactor/repositories/project_repository.dart';
import 'package:flutter_clean_arch/app/interactor/services/git_service.dart';
import 'package:flutter_clean_arch/app/interactor/states/project_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class ProjectRepositoryMock extends Mock implements ProjectRepository {}

class GitServiceMock extends Mock implements GitService {}

void main() {
  setUpAll(() {
    registerFallbackValue(Directory(''));
  });

  group('fetchAllProject | ', () {
    test('Deve pegar uma lista de projetos', () async {
      final repository = ProjectRepositoryMock();
      when(() => repository.getProjects()).thenAnswer((_) async => Success([
            ProjectEntity(
              name: 'Project 1',
              directory: Directory('path'),
              description: '',
              gitStatus: '',
            )
          ]));
      injector.replaceInstance<ProjectRepository>(repository);
      await fetchAllProject();
      expect(projectsState.value.length, 1);
    });
  });

  group('putProject | ', () {
    test('Deve atualizar um project', () async {
      final repository = ProjectRepositoryMock();
      when(() => repository.getProjects()).thenAnswer((_) async => Success([
            ProjectEntity(
              name: 'Project 1',
              directory: Directory('path'),
              description: '',
              gitStatus: '',
            )
          ]));
      injector.replaceInstance<ProjectRepository>(repository);
      await fetchAllProject();
      expect(projectsState.value.length, 1);
      final project = projectsState.value.first.copyWith(description: 'Changed');
      when(() => repository.putProject(project)).thenAnswer((_) async => Success(project));

      await putProject(project);
      expect(projectsState.value.first, project);
    });

    test('Deve add um novo project', () async {
      final repository = ProjectRepositoryMock();

      injector.replaceInstance<ProjectRepository>(repository);
      projectsState.value = [];

      final project = ProjectEntity(
        name: 'Project 1',
        directory: Directory('path'),
        description: '',
        gitStatus: '',
      );
      when(() => repository.putProject(project)).thenAnswer((_) async => Success(project));

      expect(projectsState.value.length, 0);
      await putProject(project);
      expect(projectsState.value.length, 1);
    });
  });

  group('deleteProject | ', () {
    test('Deve deletar um project', () async {
      final repository = ProjectRepositoryMock();
      when(() => repository.getProjects()).thenAnswer((_) async => Success([
            ProjectEntity(
              name: 'Project 1',
              directory: Directory('path'),
              description: '',
              gitStatus: '',
            )
          ]));
      injector.replaceInstance<ProjectRepository>(repository);
      await fetchAllProject();
      expect(projectsState.value.length, 1);

      final project = projectsState.value.first;

      when(() => repository.deleteProject(project)).thenAnswer((_) async => Success(project));

      await deleteProject(project);

      expect(projectsState.value.length, 0);
    });
  });

  group('updateProjectGitStatus | ', () {
    test('Deve atualizar um project com o status do git', () async {
      final gitService = GitServiceMock();
      final repository = ProjectRepositoryMock();
      when(() => repository.getProjects()).thenAnswer((_) async => Success([
            ProjectEntity(
              name: 'Project 1',
              directory: Directory('path'),
              description: '',
              gitStatus: '',
            )
          ]));
      when(() => gitService.getStatus(any())).thenAnswer((_) async => 'updated');

      injector.replaceInstance<ProjectRepository>(repository);
      injector.replaceInstance<GitService>(gitService);
      await fetchAllProject();
      expect(projectsState.value.length, 1);

      final project = projectsState.value.first;
      final projectWhen = project.copyWith(gitStatus: 'updated');
      when(() => repository.putProject(projectWhen)).thenAnswer((_) async => Success(projectWhen));

      await updateProjectGitStatus(project);

      expect(projectsState.value.length, 1);
      expect(projectsState.value.first.gitStatus, 'updated');
    });
  });
}
