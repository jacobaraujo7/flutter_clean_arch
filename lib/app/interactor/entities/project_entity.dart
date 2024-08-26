// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final Directory directory;
  final String name;
  final String description;
  final String gitStatus;

  const ProjectEntity({
    required this.directory,
    required this.name,
    required this.description,
    required this.gitStatus,
  });

  factory ProjectEntity.empty() {
    return ProjectEntity(
      directory: Directory(''),
      name: '',
      description: '',
      gitStatus: '',
    );
  }

  ProjectEntity copyWith({
    Directory? directory,
    String? name,
    String? description,
    String? gitStatus,
  }) {
    return ProjectEntity(
      directory: directory ?? this.directory,
      name: name ?? this.name,
      description: description ?? this.description,
      gitStatus: gitStatus ?? this.gitStatus,
    );
  }

  @override
  List<Object?> get props => [directory.path, name, description, gitStatus];
}
