import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.createAtTime,
      required this.createdAtDate,
      required this.isCompleted});

  @HiveField(0)

  ///ID
  final String id;
  @HiveField(1)

  ///title
  String title;
  @HiveField(2)

  ///subtitle
  String subtitle;
  @HiveField(3)

  ///createAtTime
  DateTime createAtTime;
  @HiveField(4)

  ///createdAtDate
  DateTime createdAtDate;
  @HiveField(5)

  ///iscompleted
  bool isCompleted;

  //create new Task
  factory Task.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
          id: const Uuid().v1(),
          title: title??"",
          subtitle: subtitle??"",
          createAtTime: createdAtTime?? DateTime.now(),
          createdAtDate: createdAtDate?? DateTime.now(),
          isCompleted: false,
      );
}
