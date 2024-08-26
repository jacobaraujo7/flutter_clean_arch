import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/app/injector.dart';

import 'app/ui/pages/project_page.dart';

void main() {
  setupInjector();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ProjectPage());
  }
}
