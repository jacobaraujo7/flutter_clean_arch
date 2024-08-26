import 'dart:io';

abstract class LauncherService {
  Future<void> launch(Directory directory);
}
