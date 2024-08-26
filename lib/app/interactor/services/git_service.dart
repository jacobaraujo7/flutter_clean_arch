import 'dart:io';

abstract class GitService {
  Future<String> getStatus(Directory path);
}
