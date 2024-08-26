import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/app/interactor/entities/project_entity.dart';
import 'package:flutter_clean_arch/app/interactor/states/project_states.dart';

import '../../interactor/actions/project_actions.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    super.initState();

    listenGitStatus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllProject();
    });

    projectsState.addListener(_listener);
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    projectsState.removeListener(_listener);
    super.dispose();
  }

  void _addOrUpdateProject(ProjectEntity project) {
    final dirText = ValueNotifier(project.directory.path);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(project.name.isEmpty ? 'Add Project' : 'Update Project'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: project.name,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => project = project.copyWith(name: value),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: project.description,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => project = project.copyWith(description: value),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.purpleAccent),
                ),
                onPressed: () async {
                  final dir = await selectProject();
                  if (dir.path.isNotEmpty) {
                    project = project.copyWith(directory: dir);
                    dirText.value = dir.path;
                  }
                },
                child: ValueListenableBuilder<String>(
                  valueListenable: dirText,
                  builder: (context, value, widget) {
                    return Text(
                      value.isEmpty ? 'Select Project' : value,
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                deleteProject(project);
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                putProject(project);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = projectsState.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return ListTile(
            title: Text(project.name),
            subtitle: Text(project.gitStatus),
            onTap: () => openProject(project),
            onLongPress: () => _addOrUpdateProject(project),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrUpdateProject(ProjectEntity.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
