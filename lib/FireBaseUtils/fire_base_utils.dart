// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/task_model.dart';
import '../Models/user_model.dart';

class FireBaseUtils {
  static CollectionReference<TaskModel> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: ((snapsshot, options) =>
              TaskModel.fromFireStore(snapsshot.data()!)),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(TaskModel task, String uId) {
    CollectionReference<TaskModel> tacskCollection = getTasksCollection(uId);
    DocumentReference<TaskModel> tacskDocumentRef = tacskCollection.doc();
    task.idTask = tacskDocumentRef.id;
    return tacskDocumentRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(TaskModel task, String uId) {
    return getTasksCollection(uId).doc(task.idTask).delete();
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (((snapshot, options) =>
              UserModel.userDataFromFireStore(snapshot.data()))),
          toFirestore: (user, _) => user.userDataToFireStore(),
        );
  }

  static Future<void> addUserToFireStore(UserModel userModel) async {
    return getUsersCollection().doc(userModel.userId).set(userModel);
  }

  static Future<UserModel?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }

  static Future<void> updateTaskFromFireStore(
      String uId, TaskModel task) async {
    return getTasksCollection(TaskModel.collectionName)
        .doc(task.idTask)
        .update(task.toFireStore());
  }

  static Future<void> editIsDoneTaskFromFireStore(
      String uId, TaskModel task) async {
    return getTasksCollection(uId).doc(task.idTask).update({
      'isDone': task.isDoneTask,
    });
  }

  static Future<void> editTaskFromFireStore(String uId, TaskModel task) async {
    return getTasksCollection(uId).doc(task.idTask).update(task.toFireStore());
  }
}
