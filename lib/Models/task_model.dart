// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  static const collectionName = 'tasks';
  String? idTask;
  String? titleTask;
  String? descriptionTask;
  DateTime? dateTask;
  bool? isDoneTask;
  TaskModel({
    this.idTask = '',
    required this.titleTask,
    required this.descriptionTask,
    required this.dateTask,
    this.isDoneTask = false,
  });
  TaskModel.fromFireStore(Map<String, dynamic> data)
      : this(
          idTask: data['id'] as String?,
          titleTask: data['title'] as String?,
          descriptionTask: data['description'] as String?,
          dateTask: DateTime.fromMillisecondsSinceEpoch(data['date']),
          isDoneTask: data['isDone'] as bool?,
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': idTask,
      'title': titleTask,
      'description': descriptionTask,
      'date': dateTask!.millisecondsSinceEpoch,
      'isDone': isDoneTask,
    };
  }
}
