import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tasksapp/data/model/task_model.dart';

class TaskRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addATask({required TaskModel taskModel}) async {
    try {
      await _firebaseFirestore.collection("tasks").add(taskModel.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('exception');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteATask({required String id}) async {
    try {
      await _firebaseFirestore.collection("tasks").doc(id).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('exception');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateTask({
    required String id,
    required TaskModel task,
  }) async {
    try {
      await _firebaseFirestore.collection("tasks").doc(id).update(task.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('exception');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getAllTasks() async {
    final List<TaskModel> tasksList = [];
    try {
      final allTasks = await _firebaseFirestore.collection("tasks").get();
      var completedCount = 0;
      for (var element in allTasks.docs) {
        tasksList.add(
          TaskModel.fromMap({
            ...element.data(),
            ...{'docId': element.id}
          }),
        );
        if (element['completed']) {
          completedCount++;
        }
      }
      return {'taskData': tasksList, 'completedCount': completedCount};
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('exception');
      }
      return {'taskData': [], 'completedCount': 0};
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
