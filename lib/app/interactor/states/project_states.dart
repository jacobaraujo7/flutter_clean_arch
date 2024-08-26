import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:flutter_clean_arch/app/interactor/exceptions/exceptions.dart';

final projectsState = ValueNotifier<List<ProjectEntity>>([]);
final projectLoadingState = ValueNotifier<bool>(false);
final projectErrorState = ValueNotifier<ProjectException?>(null);
