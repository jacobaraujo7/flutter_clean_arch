import 'package:realm/realm.dart'; // import realm package

part 'project_model.realm.dart';

@RealmModel()
class _ProjectModel {
  @PrimaryKey()
  late String path;
  late String name;
  late String description;
  late String gitStatus;
}
