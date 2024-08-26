import 'dart:io';

import 'package:flutter_clean_arch/app/interactor/services/git_service.dart';

class IoGitService implements GitService {
  @override
  Future<String> getStatus(Directory path) async {
    final result = await Process.run(
      'git',
      ['status', '--short'],
      workingDirectory: path.path,
    );

    if (result.exitCode != 0) {
      return 'Error: ${result.stderr}';
    }

    final output = result.stdout as String;
    final lines = output.split('\n').where((line) => line.isNotEmpty).map((line) => line.trim());

    final added = lines.where((line) => line.startsWith('A')).length;
    final modified = lines.where((line) => line.startsWith('M')).length;
    final deleted = lines.where((line) => line.startsWith('D')).length;
    final untracked = lines.where((line) => line.startsWith('??')).length;

    return 'Added: $added, Modified: $modified, Deleted: $deleted, Untracked: $untracked';
  }
}
