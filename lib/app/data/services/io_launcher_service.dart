import 'dart:io';

import '../../interactor/services/launcher_service.dart';

class IOLauncherService implements LauncherService {
  @override
  Future<void> launch(Directory directory) async {
    Process.start('code', [directory.path], runInShell: true);
  }
}
