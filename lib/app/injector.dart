import 'package:auto_injector/auto_injector.dart';
import 'package:flutter_clean_arch/app/data/services/io_git_service.dart';
import 'package:flutter_clean_arch/app/data/services/io_launcher_service.dart';
import 'package:flutter_clean_arch/app/interactor/repositories/project_repository.dart';
import 'package:flutter_clean_arch/app/interactor/services/git_service.dart';

import 'data/repositories/realm/realm_project_repository.dart';
import 'data/services/filepicker_choose_directory_servive.dart';
import 'interactor/services/choose_directory_service.dart';
import 'interactor/services/launcher_service.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.add(initializeRealm);
  injector.addSingleton<ProjectRepository>(RealmProjectRepository.new);

  injector.add<GitService>(IoGitService.new);
  injector.add<LauncherService>(IOLauncherService.new);

  injector.add<ChooseDirectoryService>(FilePickerChooseDirectoryService.new);

  injector.commit();
}
