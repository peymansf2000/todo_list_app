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

  void addTask({required String name, required int priority}) {
    Task newTask = Task();
    newTask.name = name;
    newTask.priority = priority;
    taskBox.put(newTask);

    debugPrint('Added Task: $newTask');
  }

  void updateTask({required Task task}) {
    taskBox.put(task);

    debugPrint('Updated Task: $task');
  }

  void removeTask({required Task task}) {
    taskBox.remove(task.id);

    debugPrint('Remove Task $task');
  }

  void removeAllTasks() {
    taskBox.removeAll();

    debugPrint('Tasks were removed');
  }

  bool isTaskBoxEmpty() {
    if (taskBox.count() == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isTaskInBox(int taskId) {
    if (taskId == 0) {
      return false;
    } else {
      return true;
    }
  }

  Stream<List<Task>> getTasks() {
    QueryBuilder<Task> builder = taskBox.query();

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<int> getTasksCount() {
    final query = taskBox.query();
    return query.watch().map((query) => query.count());
  }


  List searchTasks(String value){
    late final QueryBuilder<Task> builder;
        if (value != '') {
       builder = taskBox.query(Task_.name.contains(value));
    } else {
       builder = taskBox.query();
    }
    return builder.build().find();
  }
}
