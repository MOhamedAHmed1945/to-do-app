import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../FireBaseUtils/fire_base_utils.dart';
import '../task_model.dart';

class ListProvider extends ChangeNotifier {
  List<TaskModel> tasksList = [];
  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<TaskModel> querySnapshot =
        (await FireBaseUtils.getTasksCollection(uId).get());
    tasksList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();

    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTask!.day &&
          selectedDate.month == task.dateTask!.month &&
          selectedDate.year == task.dateTask?.year) {
        return true;
      }
      return false;
    }).toList();
    tasksList.sort((task1, task2) {
      return task1.dateTask!.compareTo(task2.dateTask!);
    });

    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();
  void changeSelectedDate(DateTime newSelectedDate,String uId) {
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
  }
}
