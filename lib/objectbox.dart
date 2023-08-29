
import 'package:flutter/material.dart';

import 'models.dart';
import 'objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Task> taskBox;
  ObjectBox._create(this.store) {
    taskBox = Box<Task>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
  void addTask({required String name, required int priority}){
    Task newTask = Task(name: name, priority: priority);
    taskBox.put(newTask);

    debugPrint('Added Task: $newTask');
  }

  Stream <List<Task>> getTasks(){
    final builder = taskBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find() );
  }
}
